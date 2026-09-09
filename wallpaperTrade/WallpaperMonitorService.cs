using Android.App;
using Android.Content;
using Android.OS;

namespace wallpaperTrade;

[Service(Enabled = true, Exported = false, ForegroundServiceType = Android.Content.PM.ForegroundService.TypeSpecialUse)]
[MetaData("android.app.PROPERTY_SPECIAL_USE_FGS_SUBTYPE", Value = "Monitoramento da tela para troca automática de wallpaper")]
public class WallpaperMonitorService : Service
{
    public const string ChangeAction = "wallpaperTrade.ACTION_CHANGE_WALLPAPER";
    private const int NotificationId = 1;
    private const string ChannelId = "wallpaper_service";
    private const string PrefsName = "wallpaper_service";
    private const string AutomaticEnabledKey = "automatic_enabled";
    private ScreenReceiver? receiver;
    private bool foregroundStarted;

    public static bool IsAutomaticEnabled(Context context)
    {
        return context.GetSharedPreferences(PrefsName, FileCreationMode.Private)?.GetBoolean(AutomaticEnabledKey, true) ?? true;
    }

    public static void SetAutomaticEnabled(Context context, bool enabled)
    {
        context.GetSharedPreferences(PrefsName, FileCreationMode.Private)?.Edit()?.PutBoolean(AutomaticEnabledKey, enabled)?.Apply();
    }

    public override void OnCreate()
    {
        base.OnCreate();
        CreateNotificationChannel();
        RegisterScreenReceiver();
    }

    public override StartCommandResult OnStartCommand(Intent? intent, StartCommandFlags flags, int startId)
    {
        if (!IsAutomaticEnabled(this))
        {
            StopSelfResult(startId);
            return StartCommandResult.NotSticky;
        }

        EnsureForeground();

        if (intent?.Action == ChangeAction)
            WallpaperChangerService.ChangeReliable(this);

        return StartCommandResult.Sticky;
    }

    private void EnsureForeground()
    {
        if (foregroundStarted)
            return;

        var notification = new Notification.Builder(this, ChannelId).SetContentTitle("Wallpaper Trade").SetContentText("Troca automática ativada").SetSmallIcon(Android.Resource.Drawable.IcMenuGallery).SetOngoing(true).Build();

        StartForeground(NotificationId, notification, Android.Content.PM.ForegroundService.TypeSpecialUse);
        foregroundStarted = true;
    }

    private void RegisterScreenReceiver()
    {
        if (receiver != null)
            return;

        receiver = new ScreenReceiver();
        RegisterReceiver(receiver, new IntentFilter(Intent.ActionScreenOff), ReceiverFlags.NotExported);
    }

    public override void OnDestroy()
    {
        if (receiver != null)
        {
            try { UnregisterReceiver(receiver); } catch { }
            receiver = null;
        }

        foregroundStarted = false;
        base.OnDestroy();
    }

    public override IBinder? OnBind(Intent? intent)
    {
        return null;
    }

    private void CreateNotificationChannel()
    {
        if (Build.VERSION.SdkInt < BuildVersionCodes.O)
            return;

        var channel = new NotificationChannel(ChannelId, "Wallpaper Trade", NotificationImportance.Low) { Description = "Serviço de troca automática de wallpaper" };
        var manager = GetSystemService(NotificationService) as NotificationManager;
        manager?.CreateNotificationChannel(channel);
    }
}

[BroadcastReceiver(Enabled = false, Exported = false)]
public class ScreenReceiver : BroadcastReceiver
{
    public override void OnReceive(Context? context, Intent? intent)
    {
        if (context == null || intent?.Action != Intent.ActionScreenOff || !WallpaperMonitorService.IsAutomaticEnabled(context))
            return;

        var appContext = context.ApplicationContext ?? context;
        var pendingResult = GoAsync();
        var powerManager = appContext.GetSystemService(Context.PowerService) as PowerManager;
        PowerManager.WakeLock? wakeLock = null;

        try
        {
            wakeLock = powerManager?.NewWakeLock(WakeLockFlags.Partial, "WallpaperTrade:ScreenOff");
            wakeLock?.Acquire(10000);
        }
        catch
        {
            wakeLock = null;
        }

        _ = Task.Run(() =>
        {
            try
            {
                WallpaperChangerService.ChangeReliable(appContext, 3, 250);
            }
            finally
            {
                try { wakeLock?.Release(); } catch { }
                pendingResult.Finish();
            }
        });
    }
}
