using Android.Content;
using Android.Content.Res;

namespace wallpaperTrade;

public static class ThemeManager
{
    public const string ModeSystem = "system";
    public const string ModeLight = "light";
    public const string ModeDark = "dark";

    private const string PrefsName = "wallpaper_theme";
    private const string ModeKey = "theme_mode";

    public static string GetMode(Context context)
    {
        string? mode = context.GetSharedPreferences(PrefsName, FileCreationMode.Private)?.GetString(ModeKey, ModeSystem);

        if (mode == ModeLight || mode == ModeDark)
            return mode;

        return ModeSystem;
    }

    public static void SetMode(Context context, string mode)
    {
        if (mode != ModeLight && mode != ModeDark)
            mode = ModeSystem;

        context.GetSharedPreferences(PrefsName, FileCreationMode.Private)?.Edit()?.PutString(ModeKey, mode)?.Apply();
    }

    // Chamado em Activity.AttachBaseContext. No modo "sistema" o contexto fica intacto e o
    // Android escolhe values/ ou values-night/ conforme o tema do aparelho. Nos modos "claro"
    // e "escuro" o uiMode noturno é forçado, o que faz o Android resolver os recursos
    // (inclusive o AppTheme) na variante correspondente.
    public static Context Wrap(Context baseContext)
    {
        UiMode night;

        switch (GetMode(baseContext))
        {
            case ModeLight:
                night = UiMode.NightNo;
                break;
            case ModeDark:
                night = UiMode.NightYes;
                break;
            default:
                return baseContext;
        }

        var current = baseContext.Resources?.Configuration;

        if (current == null)
            return baseContext;

        var configuration = new Configuration(current);
        configuration.UiMode = (configuration.UiMode & ~UiMode.NightMask) | night;

        return baseContext.CreateConfigurationContext(configuration) ?? baseContext;
    }
}
