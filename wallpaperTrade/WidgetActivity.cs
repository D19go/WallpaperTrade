using Android.App;
using Android.Appwidget;
using Android.Content;
using Android.OS;
using Android.Widget;

namespace wallpaperTrade;

[Activity(Label = "Método 3: Widget", Exported = false)]
public class WidgetActivity : ScreenActivity
{
    private TextView? status;
    private ImageView? preview;

    protected override void OnCreate(Bundle? savedInstanceState)
    {
        base.OnCreate(savedInstanceState);

        var root = Ui.Page(this, out var content);
        ApplyInsets(root);
        SetContentView(root);

        content.AddView(Ui.Label(this, "Widget na tela inicial", 22, true, 0));
        content.AddView(Ui.Label(this, "A imagem fica num widget que você posiciona na tela inicial, sem permissão especial e sem cobrir o resto. Widgets não animam nem tocam vídeo: GIF e vídeo aparecem como um quadro parado.", 15));

        content.AddView(Ui.ActionButton(this, "Escolher imagem, GIF ou vídeo", () => LayerMedia.Pick(this)));
        content.AddView(Ui.ActionButton(this, "Adicionar widget à tela inicial", AddWidget));
        content.AddView(Ui.ActionButton(this, "Atualizar widgets já adicionados", () =>
        {
            LayerWidgetProvider.Refresh(this);
            UpdateStatus();
        }));

        preview = new ImageView(this);
        preview.SetScaleType(ImageView.ScaleType.CenterCrop);
        content.AddView(preview, new Android.Widget.LinearLayout.LayoutParams(Ui.Dp(this, 200), Ui.Dp(this, 200)) { TopMargin = Ui.Dp(this, 18) });

        status = Ui.Label(this, "", 16, false, 18);
        content.AddView(status);
    }

    protected override void OnResume()
    {
        base.OnResume();
        UpdateStatus();
    }

    private void AddWidget()
    {
        var manager = AppWidgetManager.GetInstance(this);

        if (Build.VERSION.SdkInt >= BuildVersionCodes.O && manager != null && manager.IsRequestPinAppWidgetSupported)
        {
            manager.RequestPinAppWidget(LayerWidgetProvider.Component(this), null, null);
            return;
        }

        new AlertDialog.Builder(this)!
            .SetTitle("Adicionar manualmente")!
            .SetMessage("Este launcher não permite adicionar widgets pelo app. Segure a tela inicial, toque em Widgets, procure por \"Wallpaper Trade\" e arraste \"Camada (imagem)\" para a tela.")!
            .SetPositiveButton("OK", (EventHandler<DialogClickEventArgs>?)null)!
            .Show();
    }

    private void UpdateStatus()
    {
        preview?.SetImageBitmap(LayerMedia.LoadFrame(this, LayerWidgetProvider.Slot, 400));

        if (status != null)
            status.Text = $"Widgets na tela inicial: {LayerWidgetProvider.GetIds(this).Length}\n" + LayerMedia.Describe(this, LayerWidgetProvider.Slot);
    }

    protected override void OnActivityResult(int requestCode, Result resultCode, Intent? data)
    {
        base.OnActivityResult(requestCode, resultCode, data);

        if (requestCode != LayerMedia.PickRequest || resultCode != Result.Ok)
            return;

        string? error = LayerMedia.HandlePick(this, data, LayerWidgetProvider.Slot);

        if (error != null)
            Toast.MakeText(this, error, ToastLength.Long)!.Show();
        else
            LayerWidgetProvider.Refresh(this);

        UpdateStatus();
    }
}
