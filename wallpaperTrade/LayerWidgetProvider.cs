using Android.App;
using Android.Appwidget;
using Android.Content;
using Android.Widget;

namespace wallpaperTrade;

// Método 3: widget da tela inicial com a imagem escolhida. Widgets não animam nem tocam vídeo:
// GIF e vídeo aparecem como um quadro parado (o primeiro).
[BroadcastReceiver(Label = "Camada (imagem)", Exported = true)]
[IntentFilter(new[] { "android.appwidget.action.APPWIDGET_UPDATE" })]
[MetaData("android.appwidget.provider", Resource = "@xml/layer_widget_info")]
public class LayerWidgetProvider : AppWidgetProvider
{
    public const string Slot = "widget";

    public override void OnUpdate(Context? context, AppWidgetManager? appWidgetManager, int[]? appWidgetIds)
    {
        if (context == null || appWidgetManager == null || appWidgetIds == null)
            return;

        foreach (int id in appWidgetIds)
            appWidgetManager.UpdateAppWidget(id, Build(context));
    }

    public static ComponentName Component(Context context)
    {
        return new ComponentName(context, Java.Lang.Class.FromType(typeof(LayerWidgetProvider)));
    }

    public static int[] GetIds(Context context)
    {
        return AppWidgetManager.GetInstance(context)?.GetAppWidgetIds(Component(context)) ?? Array.Empty<int>();
    }

    public static void Refresh(Context context)
    {
        var manager = AppWidgetManager.GetInstance(context);

        if (manager == null)
            return;

        foreach (int id in GetIds(context))
            manager.UpdateAppWidget(id, Build(context));
    }

    private static RemoteViews Build(Context context)
    {
        var views = new RemoteViews(context.PackageName, Resource.Layout.layer_widget);
        var frame = LayerMedia.LoadFrame(context, Slot, 640);

        if (frame != null)
            views.SetImageViewBitmap(Resource.Id.widgetImage, frame);

        return views;
    }
}
