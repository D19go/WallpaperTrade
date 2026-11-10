using Android.Content;
using Android.Graphics;
using Android.Media;

namespace wallpaperTrade;

// Leitura de imagens respeitando a orientação EXIF (fotos de câmera costumam ser gravadas
// "deitadas" com uma etiqueta dizendo como girar) e preparo para papel de parede sem esticar.
public static class ImageHelper
{
    private const int MaxWallpaperSide = 4096;

    // Detecta GIF pelo cabeçalho do arquivo ("GIF87a" / "GIF89a"), sem depender da extensão.
    public static bool IsGif(string path)
    {
        try
        {
            using var stream = File.OpenRead(path);
            Span<byte> header = stackalloc byte[4];

            return stream.Read(header) == 4 && header[0] == (byte)'G' && header[1] == (byte)'I' && header[2] == (byte)'F' && header[3] == (byte)'8';
        }
        catch
        {
            return false;
        }
    }

    public static int GetOrientation(string path)
    {
        try
        {
            using var exif = new ExifInterface(path);
            return exif.GetAttributeInt(ExifInterface.TagOrientation, 1);
        }
        catch
        {
            return 1;
        }
    }

    // Miniatura para a galeria: reduzida (maior lado até maxSide) e já na orientação correta.
    public static Bitmap? LoadThumbnail(string path, int maxSide)
    {
        var (width, height) = ReadSize(path);

        if (width <= 0 || height <= 0)
            return null;

        int sample = 1;

        while (width / sample > maxSide || height / sample > maxSide)
            sample *= 2;

        var bitmap = Decode(path, sample);

        if (bitmap == null)
            return null;

        return ApplyOrientation(bitmap, GetOrientation(path));
    }

    // Papel de parede: orientação corrigida, recorte centralizado na proporção da tela
    // (sem deformar) e, se for maior que a tela, reduzido para o tamanho dela.
    public static Bitmap? LoadForWallpaper(string path, int targetWidth, int targetHeight)
    {
        if (targetWidth <= 0 || targetHeight <= 0)
            return null;

        var (width, height) = ReadSize(path);

        if (width <= 0 || height <= 0)
            return null;

        int orientation = GetOrientation(path);
        bool swapped = orientation >= 5 && orientation <= 8;
        int orientedWidth = swapped ? height : width;
        int orientedHeight = swapped ? width : height;

        // Maior redução que ainda deixa a imagem com pelo menos ~75% do tamanho da tela,
        // para não estourar a memória com fotos de muitos megapixels.
        int sample = 1;

        while (orientedWidth / (sample * 2) * 4 >= targetWidth * 3 && orientedHeight / (sample * 2) * 4 >= targetHeight * 3)
            sample *= 2;

        var decoded = Decode(path, sample);

        if (decoded == null)
            return null;

        var oriented = ApplyOrientation(decoded, orientation);
        return CropToAspectAndFit(oriented, targetWidth, targetHeight);
    }

    // Tamanho da tela em pé (lado menor x lado maior), limitado para não gerar bitmaps gigantes.
    public static (int Width, int Height) GetScreenSize(Context context)
    {
        var metrics = context.Resources?.DisplayMetrics;
        int width = metrics?.WidthPixels ?? 1080;
        int height = metrics?.HeightPixels ?? 1920;

        int shortSide = Math.Min(width, height);
        int longSide = Math.Max(width, height);

        if (shortSide <= 0 || longSide <= 0)
        {
            shortSide = 1080;
            longSide = 1920;
        }

        if (longSide > MaxWallpaperSide)
        {
            double factor = (double)MaxWallpaperSide / longSide;
            shortSide = Math.Max(1, (int)Math.Round(shortSide * factor));
            longSide = MaxWallpaperSide;
        }

        return (shortSide, longSide);
    }

    private static (int Width, int Height) ReadSize(string path)
    {
        var options = new BitmapFactory.Options { InJustDecodeBounds = true };

        BitmapFactory.DecodeFile(path, options);

        return (options.OutWidth, options.OutHeight);
    }

    private static Bitmap? Decode(string path, int sample)
    {
        var options = new BitmapFactory.Options { InSampleSize = sample, InJustDecodeBounds = false };

        return BitmapFactory.DecodeFile(path, options);
    }

    private static Bitmap ApplyOrientation(Bitmap source, int orientation)
    {
        var matrix = new Matrix();

        switch (orientation)
        {
            case 2:
                matrix.SetScale(-1f, 1f);
                break;
            case 3:
                matrix.SetRotate(180f);
                break;
            case 4:
                matrix.SetRotate(180f);
                matrix.PostScale(-1f, 1f);
                break;
            case 5:
                matrix.SetRotate(90f);
                matrix.PostScale(-1f, 1f);
                break;
            case 6:
                matrix.SetRotate(90f);
                break;
            case 7:
                matrix.SetRotate(-90f);
                matrix.PostScale(-1f, 1f);
                break;
            case 8:
                matrix.SetRotate(-90f);
                break;
            default:
                return source;
        }

        var result = Bitmap.CreateBitmap(source, 0, 0, source.Width, source.Height, matrix, true);

        if (result == null)
            return source;

        if (!ReferenceEquals(result, source))
            source.Recycle();

        return result;
    }

    private static Bitmap CropToAspectAndFit(Bitmap source, int targetWidth, int targetHeight)
    {
        double targetRatio = (double)targetWidth / targetHeight;
        double sourceRatio = (double)source.Width / source.Height;

        int cropWidth = source.Width;
        int cropHeight = source.Height;

        if (sourceRatio > targetRatio)
            cropWidth = Math.Min(source.Width, Math.Max(1, (int)Math.Round(source.Height * targetRatio)));
        else
            cropHeight = Math.Min(source.Height, Math.Max(1, (int)Math.Round(source.Width / targetRatio)));

        var current = source;

        if (cropWidth != source.Width || cropHeight != source.Height)
        {
            int x = (source.Width - cropWidth) / 2;
            int y = (source.Height - cropHeight) / 2;
            var cropped = Bitmap.CreateBitmap(source, x, y, cropWidth, cropHeight);

            if (cropped != null)
            {
                if (!ReferenceEquals(cropped, source))
                    source.Recycle();

                current = cropped;
            }
        }

        // Só reduz; ampliar fica a cargo do sistema, que mantém a proporção por ser a mesma da tela.
        if (current.Width > targetWidth || current.Height > targetHeight)
        {
            var scaled = Bitmap.CreateScaledBitmap(current, targetWidth, targetHeight, true);

            if (scaled != null)
            {
                if (!ReferenceEquals(scaled, current))
                    current.Recycle();

                current = scaled;
            }
        }

        return current;
    }
}
