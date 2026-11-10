using Android.App;
using Android.Content;
using Android.Content.PM;
using Android.OS;

[assembly: UsesFeature("android.software.live_wallpaper", Required = false)]

namespace wallpaperTrade;

// Papel de parede animado. O WallpaperManager.SetBitmap/SetStream só aceita imagem estática,
// então GIFs só podem ser exibidos por um WallpaperService próprio. O usuário ativa esse serviço
// uma única vez (diálogo do sistema); depois, a troca automática só atualiza qual arquivo
// (GIF ou imagem comum) o serviço desenha, sem precisar de nova confirmação.
//
// O serviço em si está em Java (Java/wallpapertrade/live/AnimatedWallpaperService.java), porque
// WallpaperService.Engine é uma classe interna do Android e não pode ser estendida pelo wrapper
// que o .NET gera para classes C#. Esta classe só faz a ponte: identifica o serviço e grava qual
// arquivo ele deve mostrar. O serviço é declarado no AndroidManifest.xml.
public static class GifWallpaperService
{
    // Nome da classe Java do serviço (precisa ser igual ao do AndroidManifest.xml e ao do arquivo .java).
    private const string ServiceClassName = "wallpapertrade.live.AnimatedWallpaperService";

    // Precisam ser iguais aos do AnimatedWallpaperService.java.
    private const string LivePrefs = "wallpaper_live";
    private const string CurrentHomeKey = "current_home";
    private const string CurrentLockKey = "current_lock";

    public static ComponentName Component(Context context)
    {
        return new ComponentName(context.PackageName!, ServiceClassName);
    }

    // O papel de parede animado está ativo para este destino?
    // Antes do Android 14 não dá para consultar nem ter um papel animado só na tela de bloqueio,
    // então a lista da tela de bloqueio segue como imagem estática nesses aparelhos.
    public static bool IsActive(Context context, bool home)
    {
        try
        {
            var manager = Android.App.WallpaperManager.GetInstance(context);

            if (manager == null)
                return false;

            Android.App.WallpaperInfo? info;

            if (home)
                info = manager.WallpaperInfo;
            else if (Build.VERSION.SdkInt >= BuildVersionCodes.UpsideDownCake)
                info = manager.GetWallpaperInfo(WallpaperManagerFlags.Lock);
            else
                return false;

            return info != null
                && info.PackageName == context.PackageName
                && info.ServiceName == ServiceClassName;
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
}
