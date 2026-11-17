using Android.App;
using Android.Content;
using Android.Graphics;
using Android.OS;
using Android.Views;
using Android.Widget;

namespace wallpaperTrade;

// Método 1: janela própria desenhada por cima de tudo (permissão "Exibir sobre outros apps").
// Os toques atravessam a camada (NotTouchable), então a tela por baixo continua funcionando.
[Service(Enabled = true, Exported = false, ForegroundServiceType = Android.Content.PM.ForegroundService.TypeSpecialUse)]
public class OverlayService : Service
{
    public const string Slot = "overlay";
    public const string OpacityKey = "overlay_opacity";
    public const string StopAction = "wallpaperTrade.ACTION_STOP_OVERLAY";
    private const string ChannelId = "overlay_service";
    private const int NotificationId = 2;
    private View? overlay;

    public static bool IsRunning { get; private set; }

    public static int GetOpacity(Context context)
    {
        return context.GetSharedPreferences("layer_settings", FileCreationMode.Private)?.GetInt(OpacityKey, 60) ?? 60;
    }

    public static void SetOpacity(Context context, int percent)
    {
        context.GetSharedPreferences("layer_settings", FileCreationMode.Private)?.Edit()?.PutInt(OpacityKey, percent)?.Apply();
    }

    public static void Start(Context context)
    {
        var intent = new Intent(context, typeof(OverlayService));

        if (Build.VERSION.SdkInt >= BuildVersionCodes.O)
            context.StartForegroundService(intent);
        else
            context.StartService(intent);
    }

    public static void Stop(Context context)
    {
        context.StartService(new Intent(context, typeof(OverlayService)).SetAction(StopAction));
    }

    public override void OnCreate()
    {
        base.OnCreate();
        IsRunning = true;
    }

    public override StartCommandResult OnStartCommand(Intent? intent, StartCommandFlags flags, int startId)
    {
        if (intent?.Action == StopAction)
        {
            RemoveOverlay();
            StopForeground(StopForegroundFlags.Remove);
            StopSelf();
            return StartCommandResult.NotSticky;
        }

        EnsureForeground();

        if (!ShowOverlay())
        {
            StopForeground(StopForegroundFlags.Remove);
            StopSelf();
            return StartCommandResult.NotSticky;
        }

        return StartCommandResult.Sticky;
    }

    private bool ShowOverlay()
    {
        RemoveOverlay();

        var view = LayerMedia.CreateView(this, Slot);

        if (view == null)
        {
            Toast.MakeText(this, "Escolha uma imagem, GIF ou vídeo antes de ligar a camada.", ToastLength.Long)!.Show();
            return false;
        }

        view.Alpha = GetOpacity(this) / 100f;

        var type = Build.VERSION.SdkInt >= BuildVersionCodes.O ? WindowManagerTypes.ApplicationOverlay : WindowManagerTypes.Phone;
        var flags = WindowManagerFlags.NotFocusable | WindowManagerFlags.NotTouchable | WindowManagerFlags.LayoutInScreen | WindowManagerFlags.LayoutNoLimits;
        var layout = new WindowManagerLayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.MatchParent, type, flags, Format.Translucent);

        try
        {
            (GetSystemService(WindowService) as IWindowManager)?.AddView(view, layout);
            overlay = view;
            return true;
        }
        catch (Exception ex)
        {
            Toast.MakeText(this, "Não foi possível exibir a camada: " + ex.Message, ToastLength.Long)!.Show();
            return false;
        }
    }

    private void RemoveOverlay()
    {
        if (overlay == null)
            return;

        try { (GetSystemService(WindowService) as IWindowManager)?.RemoveView(overlay); } catch { }
        overlay = null;
    }

    private void EnsureForeground()
    {
        if (Build.VERSION.SdkInt >= BuildVersionCodes.O)
        {
            var channel = new NotificationChannel(ChannelId, "Camada sobre a tela", NotificationImportance.Low);
            (GetSystemService(NotificationService) as NotificationManager)?.CreateNotificationChannel(channel);
        }

        var notification = new Notification.Builder(this, ChannelId)
            .SetContentTitle("Wallpaper Trade")!
            .SetContentText("Camada sobre a tela ligada")!
            .SetSmallIcon(Android.Resource.Drawable.IcMenuGallery)!
            .SetOngoing(true)!
            .Build()!;

        StartForeground(NotificationId, notification, Android.Content.PM.ForegroundService.TypeSpecialUse);
    }

    public override void OnDestroy()
    {
        RemoveOverlay();
        IsRunning = false;
        base.OnDestroy();
    }

    public override IBinder? OnBind(Intent? intent)
    {
        return null;
    }
}
