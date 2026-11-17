using Android.App;
using Android.Content;
using Android.Graphics;
using Android.Graphics.Drawables;
using Android.Media;
using Android.OS;
using Android.Views;
using Android.Widget;

namespace wallpaperTrade;

// Mídia (imagem, GIF ou vídeo) usada pelas telas de camada. Cada tela tem a sua ("slot"),
// para dar para testar os três métodos de forma independente. Os arquivos ficam no armazenamento privado do app.
public static class LayerMedia
{
    public const int PickRequest = 200;
    private const string Prefs = "layer_media";

    public static void Pick(Activity activity)
    {
        var intent = new Intent(Intent.ActionGetContent);
        intent.SetType("*/*");
        intent.AddCategory(Intent.CategoryOpenable);
        intent.PutExtra(Intent.ExtraMimeTypes, new[] { "image/*", "video/*" });
        activity.StartActivityForResult(Intent.CreateChooser(intent, "Escolher imagem, GIF ou vídeo"), PickRequest);
    }

    // Trata o resultado do seletor. Devolve null se deu certo ou a mensagem de erro.
    public static string? HandlePick(Context context, Intent? data, string slot)
    {
        var uri = data?.Data;

        if (uri == null)
            return "Nada foi selecionado.";

        try
        {
            string mime = context.ContentResolver!.GetType(uri) ?? "";
            bool isVideo = mime.StartsWith("video/", StringComparison.OrdinalIgnoreCase);
            string ext = isVideo ? "mp4" : mime.Contains("gif", StringComparison.OrdinalIgnoreCase) ? "gif" : mime.Contains("png", StringComparison.OrdinalIgnoreCase) ? "png" : "jpg";
            string path = System.IO.Path.Combine(context.FilesDir!.AbsolutePath, $"layer_{slot}_{Guid.NewGuid():N}.{ext}");

            using (var input = context.ContentResolver.OpenInputStream(uri))
            {
                if (input == null)
                    return "Não foi possível abrir o arquivo.";

                using var output = File.Create(path);
                input.CopyTo(output);
            }

            // Alguns seletores não informam o tipo certo: confere o conteúdo.
            if (!isVideo && ext != "gif" && ImageHelper.IsGif(path))
            {
                string gifPath = System.IO.Path.ChangeExtension(path, ".gif");
                File.Move(path, gifPath);
                path = gifPath;
            }

            var old = Get(context, slot);
            var edit = context.GetSharedPreferences(Prefs, FileCreationMode.Private)!.Edit()!;
            edit.PutString(slot + "_file", System.IO.Path.GetFileName(path));
            edit.PutBoolean(slot + "_video", isVideo);
            edit.Apply();

            if (old != null)
            {
                try { File.Delete(old.Value.Path); } catch { }
            }

            return null;
        }
        catch (Exception ex)
        {
            return "Erro ao importar: " + ex.Message;
        }
    }

    public static (string Path, bool IsVideo)? Get(Context context, string slot)
    {
        var prefs = context.GetSharedPreferences(Prefs, FileCreationMode.Private);
        string? name = prefs?.GetString(slot + "_file", null);

        if (string.IsNullOrEmpty(name))
            return null;

        string path = System.IO.Path.Combine(context.FilesDir!.AbsolutePath, name);

        return File.Exists(path) ? (path, prefs!.GetBoolean(slot + "_video", false)) : null;
    }

    public static string Describe(Context context, string slot)
    {
        var media = Get(context, slot);

        if (media == null)
            return "Nenhuma mídia escolhida.";

        string kind = media.Value.IsVideo ? "Vídeo" : ImageHelper.IsGif(media.Value.Path) ? "GIF" : "Imagem";
        return $"{kind} escolhido ({new FileInfo(media.Value.Path).Length / 1024} KB).";
    }

    // View que mostra a mídia preenchendo o espaço: imagem recortada, GIF animado ou vídeo em loop sem som.
    public static View? CreateView(Context context, string slot)
    {
        var media = Get(context, slot);

        if (media == null)
            return null;

        var (path, isVideo) = media.Value;

        if (isVideo)
        {
            var holder = new FrameLayout(context);
            var video = new VideoView(context);
            video.SetOnPreparedListener(new LoopSilently());
            video.SetVideoPath(path);
            holder.AddView(video, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.MatchParent, GravityFlags.Center));
            video.Start();
            return holder;
        }

        var image = new ImageView(context);
        image.SetScaleType(ImageView.ScaleType.CenterCrop);

        if (ImageHelper.IsGif(path) && Build.VERSION.SdkInt >= BuildVersionCodes.P)
        {
            try
            {
                var drawable = ImageDecoder.DecodeDrawable(ImageDecoder.CreateSource(new Java.IO.File(path)));
                image.SetImageDrawable(drawable);

                if (drawable is AnimatedImageDrawable animated)
                {
                    animated.RepeatCount = AnimatedImageDrawable.RepeatInfinite;
                    animated.Start();
                }

                return image;
            }
            catch
            {
                // cai para a imagem parada abaixo
            }
        }

        var (w, h) = ImageHelper.GetScreenSize(context);
        image.SetImageBitmap(ImageHelper.LoadForWallpaper(path, w, h));
        return image;
    }

    // Um quadro parado da mídia (para o widget, que não anima). Vídeo usa o primeiro quadro.
    public static Bitmap? LoadFrame(Context context, string slot, int size)
    {
        var media = Get(context, slot);

        if (media == null)
            return null;

        var (path, isVideo) = media.Value;

        if (!isVideo)
            return ImageHelper.LoadForWallpaper(path, size, size);

        try
        {
            using var retriever = new MediaMetadataRetriever();
            retriever.SetDataSource(path);
            var frame = retriever.GetFrameAtTime(0);

            if (frame == null)
                return null;

            var scaled = Bitmap.CreateScaledBitmap(frame, size, size * frame.Height / Math.Max(1, frame.Width), true);
            return scaled;
        }
        catch
        {
            return null;
        }
    }

    private class LoopSilently : Java.Lang.Object, MediaPlayer.IOnPreparedListener
    {
        public void OnPrepared(MediaPlayer? mp)
        {
            if (mp == null)
                return;

            mp.Looping = true;
            mp.SetVolume(0f, 0f);
        }
    }
}
