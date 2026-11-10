#pragma warning disable CA1416 // AnimatedImageDrawable/ImageDecoder só são usados com checagem de versão (API 28+).

using Android.App;
using Android.Content;
using Android.Content.PM;
using Android.Graphics;
using Android.Graphics.Drawables;
using Android.OS;
using Android.Service.Wallpaper;
using Android.Views;

[assembly: UsesFeature("android.software.live_wallpaper", Required = false)]

namespace wallpaperTrade;

// Papel de parede animado. O WallpaperManager.SetBitmap/SetStream só aceita imagem estática,
// então GIFs só podem ser exibidos por um WallpaperService próprio. O usuário ativa este
// serviço uma única vez (diálogo do sistema); depois, a troca automática só atualiza qual
// arquivo (GIF ou imagem comum) o serviço desenha, sem precisar de nova confirmação.
[Service(Label = "Wallpaper Trade (animado)", Permission = "android.permission.BIND_WALLPAPER", Exported = true)]
[IntentFilter(new[] { "android.service.wallpaper.WallpaperService" })]
[MetaData("android.service.wallpaper", Resource = "@xml/gif_wallpaper")]
public class GifWallpaperService : WallpaperService
{
    private const string LivePrefs = "wallpaper_live";
    private const string CurrentHomeKey = "current_home";
    private const string CurrentLockKey = "current_lock";
    private const int FrameDelayMs = 33; // ~30 quadros por segundo

    public override WallpaperService.Engine? OnCreateEngine()
    {
        return new GifEngine(this);
    }

    public static ComponentName Component(Context context)
    {
        return new ComponentName(context.PackageName!, Java.Lang.Class.FromType(typeof(GifWallpaperService)).Name!);
    }

    // O papel de parede animado está ativo para este destino?
    // Antes do Android 14 não dá para consultar nem ter um papel animado só na tela de bloqueio,
    // então a lista da tela de bloqueio segue como imagem estática nesses aparelhos.
    public static bool IsActive(Context context, bool home)
    {
        try
        {
            var manager = WallpaperManager.GetInstance(context);

            if (manager == null)
                return false;

            WallpaperInfo? info;

            if (home)
                info = manager.WallpaperInfo;
            else if (Build.VERSION.SdkInt >= BuildVersionCodes.UpsideDownCake)
                info = manager.GetWallpaperInfo(WallpaperManagerFlags.Lock);
            else
                return false;

            return info != null
                && info.PackageName == context.PackageName
                && info.ServiceName == Java.Lang.Class.FromType(typeof(GifWallpaperService)).Name;
        }
        catch
        {
            return false;
        }
    }

    public static void SetCurrent(Context context, bool home, string fileName)
    {
        context.GetSharedPreferences(LivePrefs, FileCreationMode.Private)?.Edit()?.PutString(home ? CurrentHomeKey : CurrentLockKey, fileName)?.Apply();
    }

    private static string? GetCurrent(Context context, bool home)
    {
        return context.GetSharedPreferences(LivePrefs, FileCreationMode.Private)?.GetString(home ? CurrentHomeKey : CurrentLockKey, null);
    }

    private class GifEngine : WallpaperService.Engine
    {
        private readonly GifWallpaperService service;
        private readonly Handler handler = new(Looper.MainLooper!);
        private readonly Java.Lang.Runnable drawRunnable;

        private bool visible;
        private int width;
        private int height;
        private string? loadedFile;
        private Bitmap? still;
        private Drawable? animated;
        private Movie? movie;
        private long movieStart;

        public GifEngine(GifWallpaperService service) : base(service)
        {
            this.service = service;
            drawRunnable = new Java.Lang.Runnable(Draw);
        }

        public override void OnVisibilityChanged(bool visible)
        {
            this.visible = visible;

            if (visible)
            {
                // A troca automática roda com a tela desligada: ao voltar a ficar visível, relê qual arquivo mostrar.
                LoadCurrent();
                Draw();
            }
            else
            {
                handler.RemoveCallbacks(drawRunnable);
                StopAnimation();
            }
        }

        public override void OnSurfaceChanged(ISurfaceHolder? holder, Format format, int width, int height)
        {
            base.OnSurfaceChanged(holder, format, width, height);

            if (width != this.width || height != this.height)
            {
                this.width = width;
                this.height = height;
                ReleaseMedia(); // a imagem estática depende do tamanho da tela
            }

            LoadCurrent();
            Draw();
        }

        public override void OnSurfaceDestroyed(ISurfaceHolder? holder)
        {
            visible = false;
            handler.RemoveCallbacks(drawRunnable);
            base.OnSurfaceDestroyed(holder);
        }

        public override void OnDestroy()
        {
            visible = false;
            handler.RemoveCallbacks(drawRunnable);
            ReleaseMedia();
            base.OnDestroy();
        }

        private bool IsLockEngine()
        {
            if (Build.VERSION.SdkInt < BuildVersionCodes.UpsideDownCake)
                return false;

            int flags = (int)WallpaperFlags;
            return (flags & 2) != 0 && (flags & 1) == 0; // somente FLAG_LOCK
        }

        private string? ResolveFile()
        {
            bool lockEngine = IsLockEngine();
            string? name = GetCurrent(service, !lockEngine);

            if (name != null && File.Exists(System.IO.Path.Combine(service.FilesDir!.AbsolutePath, name)))
                return name;

            // Ainda não houve troca: começa pelo primeiro item da lista.
            return WallpaperChangerService.Images(service, lockEngine ? "lock" : "home").FirstOrDefault();
        }

        private void LoadCurrent()
        {
            string? file = ResolveFile();

            if (file == loadedFile && (still != null || animated != null || movie != null))
                return;

            ReleaseMedia();
            loadedFile = file;

            if (file == null || width <= 0 || height <= 0)
                return;

            string path = System.IO.Path.Combine(service.FilesDir!.AbsolutePath, file);

            try
            {
                if (ImageHelper.IsGif(path))
                    LoadGif(path);
                else
                    still = ImageHelper.LoadForWallpaper(path, width, height);
            }
            catch
            {
                ReleaseMedia();
            }
        }

        private void LoadGif(string path)
        {
            if (Build.VERSION.SdkInt >= BuildVersionCodes.P)
            {
                var source = ImageDecoder.CreateSource(new Java.IO.File(path));
                animated = ImageDecoder.DecodeDrawable(source, new HeaderListener(Math.Max(width, height)));

                if (animated is AnimatedImageDrawable gif)
                {
                    gif.RepeatCount = AnimatedImageDrawable.RepeatInfinite;
                    gif.Start();
                }
            }
            else
            {
                using var stream = File.OpenRead(path);
                movie = Movie.DecodeStream(stream);
                movieStart = SystemClock.UptimeMillis();
            }
        }

        private void StopAnimation()
        {
            if (animated is AnimatedImageDrawable gif)
            {
                try { gif.Stop(); } catch { }
            }
        }

        private void ReleaseMedia()
        {
            StopAnimation();
            animated = null;
            movie = null;

            try { still?.Recycle(); } catch { }

            still = null;
            loadedFile = null;
        }

        private void Draw()
        {
            if (!visible)
                return;

            var holder = SurfaceHolder;
            Canvas? canvas = null;

            try
            {
                canvas = holder?.LockCanvas();

                if (canvas != null)
                    DrawFrame(canvas);
            }
            catch
            {
            }
            finally
            {
                if (canvas != null)
                {
                    try { holder!.UnlockCanvasAndPost(canvas); } catch { }
                }
            }

            handler.RemoveCallbacks(drawRunnable);

            // Imagem estática é desenhada uma vez; só GIFs mantêm o laço de quadros.
            if (visible && (animated is AnimatedImageDrawable || movie != null))
                handler.PostDelayed(drawRunnable, FrameDelayMs);
        }

        private void DrawFrame(Canvas canvas)
        {
            canvas.DrawColor(Color.Black);

            if (still != null)
            {
                canvas.DrawBitmap(still, null, new Rect(0, 0, width, height), null);
                return;
            }

            if (animated != null)
            {
                int w = animated.IntrinsicWidth;
                int h = animated.IntrinsicHeight;

                if (w <= 0 || h <= 0)
                    return;

                // "Cobrir" a tela mantendo a proporção (recorte centralizado), igual às imagens estáticas.
                float scale = Math.Max(width / (float)w, height / (float)h);

                canvas.Save();
                canvas.Translate((width - w * scale) / 2f, (height - h * scale) / 2f);
                canvas.Scale(scale, scale);
                animated.SetBounds(0, 0, w, h);
                animated.Draw(canvas);
                canvas.Restore();
                return;
            }

            if (movie != null)
            {
                int w = movie.Width();
                int h = movie.Height();

                if (w <= 0 || h <= 0)
                    return;

                int duration = movie.Duration();

                if (duration <= 0)
                    duration = 1000;

                movie.SetTime((int)((SystemClock.UptimeMillis() - movieStart) % duration));

                float scale = Math.Max(width / (float)w, height / (float)h);

                canvas.Save();
                canvas.Translate((width - w * scale) / 2f, (height - h * scale) / 2f);
                canvas.Scale(scale, scale);
                movie.Draw(canvas, 0, 0);
                canvas.Restore();
            }
        }
    }

    // Limita o tamanho decodificado do GIF para não estourar a memória com arquivos enormes.
    private class HeaderListener : Java.Lang.Object, ImageDecoder.IOnHeaderDecodedListener
    {
        private readonly int screenLongSide;

        public HeaderListener(int screenLongSide)
        {
            this.screenLongSide = Math.Max(screenLongSide, 720);
        }

        public void OnHeaderDecoded(ImageDecoder decoder, ImageDecoder.ImageInfo info, ImageDecoder.Source source)
        {
            int longSide = Math.Max(info.Size.Width, info.Size.Height);
            int sample = 1;

            while (longSide / (sample * 2) >= screenLongSide)
                sample *= 2;

            if (sample > 1)
                decoder.SetTargetSampleSize(sample);
        }
    }
}
