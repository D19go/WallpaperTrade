using Android.App;
using Android.Content;
using Android.OS;

namespace wallpaperTrade;

[BroadcastReceiver(Enabled = true, Exported = true, DirectBootAware = false)]
[IntentFilter(new[] { Intent.ActionBootCompleted, Intent.ActionMyPackageReplaced })]
public class BootReceiver : BroadcastReceiver
{
    public override void OnReceive(Context? context, Intent? intent)
    {
        if (context == null)
            return;

        if (intent?.Action != Intent.ActionBootCompleted && intent?.Action != Intent.ActionMyPackageReplaced)
            return;

        if (!WallpaperMonitorService.IsAutomaticEnabled(context))
            return;

        try
        {
            var serviceIntent = new Intent(context, typeof(WallpaperMonitorService));

            if (Build.VERSION.SdkInt >= BuildVersionCodes.O)
                context.StartForegroundService(serviceIntent);
            else
                context.StartService(serviceIntent);
        }
        catch
        {
            // O sistema poderá recriar o serviço posteriormente quando permitido.
        }
    }
}
