using Android.App;
using Android.Content;
using Android.Net;
using Android.OS;
using Android.Provider;
using Android.Widget;

namespace wallpaperTrade;

[Activity(Label = "Método 1: Overlay", Exported = false)]
public class OverlayActivity : ScreenActivity
{
    private TextView? status;

    protected override void OnCreate(Bundle? savedInstanceState)
    {
        base.OnCreate(savedInstanceState);

        var root = Ui.Page(this, out var content);
        ApplyInsets(root);
        SetContentView(root);

        content.AddView(Ui.Label(this, "Overlay sobre os apps", 22, true, 0));
        content.AddView(Ui.Label(this, "Uma janela própria é desenhada por cima de tudo (inclusive de outros apps), com imagem, GIF ou vídeo. Os toques atravessam a camada, então a tela continua funcionando. Ela cobre o plano de fundo, os ícones e os apps: use a transparência para enxergar o que está embaixo.", 15));

        content.AddView(Ui.ActionButton(this, "Escolher imagem, GIF ou vídeo", () => LayerMedia.Pick(this)));

        content.AddView(Ui.Label(this, "Transparência da camada", 16, false, 18));
        var seek = new SeekBar(this) { Max = 100, Progress = OverlayService.GetOpacity(this) };
        seek.StopTrackingTouch += (_, _) =>
        {
            int value = Math.Max(10, seek.Progress);
            OverlayService.SetOpacity(this, value);

            if (OverlayService.IsRunning)
                OverlayService.Start(this);
        };
        content.AddView(seek);

        content.AddView(Ui.ActionButton(this, "Ligar camada", TurnOn));
        content.AddView(Ui.ActionButton(this, "Desligar camada", () =>
        {
            OverlayService.Stop(this);
            status?.PostDelayed(UpdateStatus, 400);
        }));

        status = Ui.Label(this, "", 16, false, 18);
        content.AddView(status);
    }

    protected override void OnResume()
    {
        base.OnResume();
        UpdateStatus();
    }

    private void TurnOn()
    {
        if (!Settings.CanDrawOverlays(this))
        {
            Toast.MakeText(this, "Permita \"Exibir sobre outros apps\" para o Wallpaper Trade e volte.", ToastLength.Long)!.Show();
            StartActivity(new Intent(Settings.ActionManageOverlayPermission, Uri.Parse("package:" + PackageName)));
            return;
        }

        OverlayService.Start(this);
        status?.PostDelayed(UpdateStatus, 400);
    }

    private void UpdateStatus()
    {
        if (status == null)
            return;

        status.Text = $"Permissão \"Exibir sobre outros apps\": {(Settings.CanDrawOverlays(this) ? "concedida" : "não concedida")}\n" +
                      $"Camada: {(OverlayService.IsRunning ? "ligada" : "desligada")}\n" +
                      LayerMedia.Describe(this, OverlayService.Slot);
    }

    protected override void OnActivityResult(int requestCode, Result resultCode, Intent? data)
    {
        base.OnActivityResult(requestCode, resultCode, data);

        if (requestCode != LayerMedia.PickRequest || resultCode != Result.Ok)
            return;

        string? error = LayerMedia.HandlePick(this, data, OverlayService.Slot);

        if (error != null)
            Toast.MakeText(this, error, ToastLength.Long)!.Show();
        else if (OverlayService.IsRunning)
            OverlayService.Start(this);

        UpdateStatus();
    }
}
