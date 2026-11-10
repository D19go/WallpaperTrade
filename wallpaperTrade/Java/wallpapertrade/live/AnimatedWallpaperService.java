package wallpapertrade.live;

import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ImageDecoder;
import android.graphics.Matrix;
import android.graphics.Movie;
import android.graphics.Rect;
import android.graphics.drawable.AnimatedImageDrawable;
import android.graphics.drawable.Drawable;
import android.media.ExifInterface;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.service.wallpaper.WallpaperService;
import android.util.Size;
import android.view.SurfaceHolder;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

// Papel de parede animado do Wallpaper Trade.
//
// Esta classe é escrita em Java (e não em C#) de propósito: WallpaperService.Engine é uma classe
// INTERNA do Android, e o Java só deixa estendê-la de dentro do próprio WallpaperService. O wrapper
// Java que o .NET gera para uma subclasse em C# é uma classe de nível superior e não compila
// ("an enclosing instance that contains WallpaperService.Engine is required").
//
// O C# (GifWallpaperService.cs) só ativa este serviço e informa qual arquivo mostrar, gravando em
// SharedPreferences; este serviço lê esses mesmos arquivos e preferências.
public class AnimatedWallpaperService extends WallpaperService {
    // Precisam ser iguais aos de GifWallpaperService.cs e WallpaperChangerService.cs.
    private static final String LIVE_PREFS = "wallpaper_live";
    private static final String CURRENT_HOME_KEY = "current_home";
    private static final String CURRENT_LOCK_KEY = "current_lock";
    private static final String MAIN_PREFS = "wallpaper";
    private static final String HOME_IMAGES_KEY = "home_images";
    private static final String LOCK_IMAGES_KEY = "lock_images";

    private static final int FRAME_DELAY_MS = 33; // ~30 quadros por segundo

    // WallpaperManager.FLAG_SYSTEM e FLAG_LOCK.
    private static final int FLAG_SYSTEM = 1;
    private static final int FLAG_LOCK = 2;

    @Override
    public Engine onCreateEngine() {
        return new GifEngine();
    }

    private class GifEngine extends Engine {
        private final Handler handler = new Handler(Looper.getMainLooper());
        private final Runnable drawRunnable = new Runnable() {
            @Override
            public void run() {
                draw();
            }
        };

        private boolean visible;
        private int width;
        private int height;
        private String loadedFile;
        private Bitmap still;
        private Drawable animated;
        private Movie movie;
        private long movieStart;

        @Override
        public void onVisibilityChanged(boolean isVisible) {
            visible = isVisible;

            if (isVisible) {
                // A troca automática roda com a tela desligada: ao voltar a ficar visível, relê qual arquivo mostrar.
                loadCurrent();
                draw();
            } else {
                handler.removeCallbacks(drawRunnable);
                stopAnimation();
            }
        }

        @Override
        public void onSurfaceChanged(SurfaceHolder holder, int format, int w, int h) {
            super.onSurfaceChanged(holder, format, w, h);

            if (w != width || h != height) {
                width = w;
                height = h;
                releaseMedia(); // a imagem estática depende do tamanho da tela
            }

            loadCurrent();
            draw();
        }

        @Override
        public void onSurfaceDestroyed(SurfaceHolder holder) {
            visible = false;
            handler.removeCallbacks(drawRunnable);
            super.onSurfaceDestroyed(holder);
        }

        @Override
        public void onDestroy() {
            visible = false;
            handler.removeCallbacks(drawRunnable);
            releaseMedia();
            super.onDestroy();
        }

        private boolean isLockEngine() {
            if (Build.VERSION.SDK_INT < 34) {
                return false;
            }

            int flags = getWallpaperFlags();
            return (flags & FLAG_LOCK) != 0 && (flags & FLAG_SYSTEM) == 0; // somente FLAG_LOCK
        }

        private String resolveFile() {
            boolean lock = isLockEngine();
            File dir = getFilesDir();

            SharedPreferences live = getSharedPreferences(LIVE_PREFS, MODE_PRIVATE);
            String name = live.getString(lock ? CURRENT_LOCK_KEY : CURRENT_HOME_KEY, null);

            if (name != null && new File(dir, name).exists()) {
                return name;
            }

            // Ainda não houve troca: começa pelo primeiro item da lista.
            SharedPreferences main = getSharedPreferences(MAIN_PREFS, MODE_PRIVATE);
            String list = main.getString(lock ? LOCK_IMAGES_KEY : HOME_IMAGES_KEY, "");

            if (list != null) {
                for (String item : list.split("\\|")) {
                    if (!item.isEmpty() && new File(dir, item).exists()) {
                        return item;
                    }
                }
            }

            return null;
        }

        private void loadCurrent() {
            String file = resolveFile();

            if (file != null && file.equals(loadedFile) && (still != null || animated != null || movie != null)) {
                return;
            }

            releaseMedia();
            loadedFile = file;

            if (file == null || width <= 0 || height <= 0) {
                return;
            }

            String path = new File(getFilesDir(), file).getAbsolutePath();

            try {
                if (isGif(path)) {
                    loadGif(path);
                } else {
                    still = loadStill(path, width, height);
                }
            } catch (Throwable t) {
                releaseMedia();
            }
        }

        private void loadGif(String path) throws Exception {
            if (Build.VERSION.SDK_INT >= 28) {
                final int screenLongSide = Math.max(Math.max(width, height), 720);
                ImageDecoder.Source source = ImageDecoder.createSource(new File(path));

                animated = ImageDecoder.decodeDrawable(source, new ImageDecoder.OnHeaderDecodedListener() {
                    @Override
                    public void onHeaderDecoded(ImageDecoder decoder, ImageDecoder.ImageInfo info, ImageDecoder.Source src) {
                        // Limita o tamanho decodificado para não estourar a memória com GIFs enormes.
                        Size size = info.getSize();
                        int longSide = Math.max(size.getWidth(), size.getHeight());
                        int sample = 1;

                        while (longSide / (sample * 2) >= screenLongSide) {
                            sample *= 2;
                        }

                        if (sample > 1) {
                            decoder.setTargetSampleSize(sample);
                        }
                    }
                });

                if (animated instanceof AnimatedImageDrawable) {
                    AnimatedImageDrawable gif = (AnimatedImageDrawable) animated;
                    gif.setRepeatCount(AnimatedImageDrawable.REPEAT_INFINITE);
                    gif.start();
                }
            } else {
                InputStream stream = new FileInputStream(path);

                try {
                    movie = Movie.decodeStream(stream);
                } finally {
                    stream.close();
                }

                movieStart = SystemClock.uptimeMillis();
            }
        }

        private void stopAnimation() {
            if (animated instanceof AnimatedImageDrawable) {
                try {
                    ((AnimatedImageDrawable) animated).stop();
                } catch (Throwable ignored) {
                }
            }
        }

        private void releaseMedia() {
            stopAnimation();
            animated = null;
            movie = null;

            if (still != null) {
                try {
                    still.recycle();
                } catch (Throwable ignored) {
                }
            }

            still = null;
            loadedFile = null;
        }

        private void draw() {
            if (!visible) {
                return;
            }

            SurfaceHolder holder = getSurfaceHolder();
            Canvas canvas = null;

            try {
                canvas = holder.lockCanvas();

                if (canvas != null) {
                    drawFrame(canvas);
                }
            } catch (Throwable ignored) {
            } finally {
                if (canvas != null) {
                    try {
                        holder.unlockCanvasAndPost(canvas);
                    } catch (Throwable ignored) {
                    }
                }
            }

            handler.removeCallbacks(drawRunnable);

            // Imagem estática é desenhada uma vez; só GIFs mantêm o laço de quadros.
            if (visible && (animated instanceof AnimatedImageDrawable || movie != null)) {
                handler.postDelayed(drawRunnable, FRAME_DELAY_MS);
            }
        }

        private void drawFrame(Canvas canvas) {
            canvas.drawColor(Color.BLACK);

            if (still != null) {
                canvas.drawBitmap(still, null, new Rect(0, 0, width, height), null);
                return;
            }

            if (animated != null) {
                int w = animated.getIntrinsicWidth();
                int h = animated.getIntrinsicHeight();

                if (w <= 0 || h <= 0) {
                    return;
                }

                // "Cobrir" a tela mantendo a proporção (recorte centralizado), igual às imagens estáticas.
                float scale = Math.max(width / (float) w, height / (float) h);

                canvas.save();
                canvas.translate((width - w * scale) / 2f, (height - h * scale) / 2f);
                canvas.scale(scale, scale);
                animated.setBounds(0, 0, w, h);
                animated.draw(canvas);
                canvas.restore();
                return;
            }

            if (movie != null) {
                int w = movie.width();
                int h = movie.height();

                if (w <= 0 || h <= 0) {
                    return;
                }

                int duration = movie.duration();

                if (duration <= 0) {
                    duration = 1000;
                }

                movie.setTime((int) ((SystemClock.uptimeMillis() - movieStart) % duration));

                float scale = Math.max(width / (float) w, height / (float) h);

                canvas.save();
                canvas.translate((width - w * scale) / 2f, (height - h * scale) / 2f);
                canvas.scale(scale, scale);
                movie.draw(canvas, 0, 0);
                canvas.restore();
            }
        }
    }

    // Detecta GIF pelo cabeçalho do arquivo ("GIF87a" / "GIF89a"), sem depender da extensão.
    private static boolean isGif(String path) {
        try {
            InputStream stream = new FileInputStream(path);

            try {
                byte[] header = new byte[4];
                return stream.read(header) == 4 && header[0] == 'G' && header[1] == 'I' && header[2] == 'F' && header[3] == '8';
            } finally {
                stream.close();
            }
        } catch (Throwable t) {
            return false;
        }
    }

    // Imagem comum: orientação EXIF corrigida e recorte centralizado na proporção da tela (igual ao ImageHelper.cs).
    private static Bitmap loadStill(String path, int targetWidth, int targetHeight) {
        BitmapFactory.Options bounds = new BitmapFactory.Options();
        bounds.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(path, bounds);

        if (bounds.outWidth <= 0 || bounds.outHeight <= 0) {
            return null;
        }

        int orientation = ExifInterface.ORIENTATION_NORMAL;

        try {
            orientation = new ExifInterface(path).getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL);
        } catch (Throwable ignored) {
        }

        boolean swapped = orientation >= 5 && orientation <= 8;
        int orientedWidth = swapped ? bounds.outHeight : bounds.outWidth;
        int orientedHeight = swapped ? bounds.outWidth : bounds.outHeight;

        // Maior redução que ainda deixa a imagem com pelo menos ~75% do tamanho da tela.
        int sample = 1;

        while (orientedWidth / (sample * 2) * 4 >= targetWidth * 3 && orientedHeight / (sample * 2) * 4 >= targetHeight * 3) {
            sample *= 2;
        }

        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inSampleSize = sample;
        Bitmap decoded = BitmapFactory.decodeFile(path, options);

        if (decoded == null) {
            return null;
        }

        Bitmap oriented = applyOrientation(decoded, orientation);
        return cropToAspect(oriented, targetWidth, targetHeight);
    }

    private static Bitmap applyOrientation(Bitmap source, int orientation) {
        Matrix matrix = new Matrix();

        switch (orientation) {
            case ExifInterface.ORIENTATION_FLIP_HORIZONTAL:
                matrix.setScale(-1f, 1f);
                break;
            case ExifInterface.ORIENTATION_ROTATE_180:
                matrix.setRotate(180f);
                break;
            case ExifInterface.ORIENTATION_FLIP_VERTICAL:
                matrix.setRotate(180f);
                matrix.postScale(-1f, 1f);
                break;
            case ExifInterface.ORIENTATION_TRANSPOSE:
                matrix.setRotate(90f);
                matrix.postScale(-1f, 1f);
                break;
            case ExifInterface.ORIENTATION_ROTATE_90:
                matrix.setRotate(90f);
                break;
            case ExifInterface.ORIENTATION_TRANSVERSE:
                matrix.setRotate(-90f);
                matrix.postScale(-1f, 1f);
                break;
            case ExifInterface.ORIENTATION_ROTATE_270:
                matrix.setRotate(-90f);
                break;
            default:
                return source;
        }

        Bitmap result = Bitmap.createBitmap(source, 0, 0, source.getWidth(), source.getHeight(), matrix, true);

        if (result != null && result != source) {
            source.recycle();
            return result;
        }

        return source;
    }

    private static Bitmap cropToAspect(Bitmap source, int targetWidth, int targetHeight) {
        double targetRatio = (double) targetWidth / targetHeight;
        double sourceRatio = (double) source.getWidth() / source.getHeight();

        int cropWidth = source.getWidth();
        int cropHeight = source.getHeight();

        if (sourceRatio > targetRatio) {
            cropWidth = Math.min(source.getWidth(), Math.max(1, (int) Math.round(source.getHeight() * targetRatio)));
        } else {
            cropHeight = Math.min(source.getHeight(), Math.max(1, (int) Math.round(source.getWidth() / targetRatio)));
        }

        if (cropWidth == source.getWidth() && cropHeight == source.getHeight()) {
            return source;
        }

        int x = (source.getWidth() - cropWidth) / 2;
        int y = (source.getHeight() - cropHeight) / 2;
        Bitmap cropped = Bitmap.createBitmap(source, x, y, cropWidth, cropHeight);

        if (cropped != null && cropped != source) {
            source.recycle();
            return cropped;
        }

        return source;
    }
}
