using Android.App;
using Android.Content;
using Android.Content.PM;
using Android.Graphics;
using Android.Graphics.Drawables;
using Android.OS;
using Android.Views;
using Android.Widget;

namespace wallpaperTrade;

// Método 2: camada entre o plano de fundo e os ícones. Um app comum não consegue inserir nada na tela
// de outro launcher, então aqui é uma TELA INICIAL SIMULADA dentro do app: fundo, a sua camada e,
// por cima, os ícones dos apps instalados (que abrem de verdade). Em um launcher próprio seria igual.
[Activity(Label = "Método 2: Camada no launcher", Exported = false)]
public class LauncherLayerActivity : ScreenActivity
{
    private const string Slot = "launcher";
    private const string OpacityKey = "launcher_opacity";
    private FrameLayout? mediaHolder;
    private TextView? status;
    private View? mediaView;

    protected override void OnCreate(Bundle? savedInstanceState)
    {
        base.OnCreate(savedInstanceState);

        var root = new FrameLayout(this);

        // Camada 0: plano de fundo (simulado).
        var background = new View(this);
        background.Background = new GradientDrawable(GradientDrawable.Orientation.TopBottom, new[] { Color.ParseColor("#1B2A49").ToArgb(), Color.ParseColor("#6B2D5C").ToArgb() });
        root.AddView(background, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.MatchParent));

        // Camada 1: a mídia escolhida.
        mediaHolder = new FrameLayout(this);
        root.AddView(mediaHolder, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.MatchParent));

        // Camada 2: ícones dos apps.
        var grid = new GridView(this) { NumColumns = 4 };
        grid.SetPadding(Ui.Dp(this, 12), Ui.Dp(this, 12), Ui.Dp(this, 12), Ui.Dp(this, 190));
        grid.SetClipToPadding(false);
        grid.SetVerticalSpacing(Ui.Dp(this, 14));
        var adapter = new AppsAdapter(this);
        grid.Adapter = adapter;
        grid.ItemClick += (_, e) =>
        {
            var intent = PackageManager!.GetLaunchIntentForPackage(adapter.PackageAt(e.Position) ?? "");

            if (intent != null)
                StartActivity(intent);
        };
        root.AddView(grid, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.MatchParent));

        // Painel de controles, por cima de tudo.
        var panel = new LinearLayout(this) { Orientation = Orientation.Vertical };
        panel.SetBackgroundColor(Color.ParseColor("#CC000000"));
        panel.SetPadding(Ui.Dp(this, 16), Ui.Dp(this, 10), Ui.Dp(this, 16), Ui.Dp(this, 10));

        var pick = new Button(this) { Text = "Escolher imagem, GIF ou vídeo da camada" };
        pick.Click += (_, _) => LayerMedia.Pick(this);
        panel.AddView(pick);

        var seek = new SeekBar(this) { Max = 100, Progress = GetOpacity() };
        seek.ProgressChanged += (_, e) =>
        {
            if (mediaView != null)
                mediaView.Alpha = Math.Max(10, e.Progress) / 100f;
        };
        seek.StopTrackingTouch += (_, _) => GetSharedPreferences("layer_settings", FileCreationMode.Private)?.Edit()?.PutInt(OpacityKey, seek.Progress)?.Apply();
        panel.AddView(seek);

        status = new TextView(this) { TextSize = 13 };
        status.SetTextColor(Color.White);
        panel.AddView(status);

        var panelParams = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.WrapContent, GravityFlags.Bottom);
        root.AddView(panel, panelParams);

        ApplyInsets(root);
        SetContentView(root);
        RefreshMedia();
    }

    private int GetOpacity()
    {
        return GetSharedPreferences("layer_settings", FileCreationMode.Private)?.GetInt(OpacityKey, 70) ?? 70;
    }

    private void RefreshMedia()
    {
        mediaHolder?.RemoveAllViews();
        mediaView = LayerMedia.CreateView(this, Slot);

        if (mediaView != null)
        {
            mediaView.Alpha = Math.Max(10, GetOpacity()) / 100f;
            mediaHolder?.AddView(mediaView, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.MatchParent));
        }

        if (status != null)
            status.Text = "Ordem: fundo → camada → ícones. " + LayerMedia.Describe(this, Slot);
    }

    protected override void OnActivityResult(int requestCode, Result resultCode, Intent? data)
    {
        base.OnActivityResult(requestCode, resultCode, data);

        if (requestCode != LayerMedia.PickRequest || resultCode != Result.Ok)
            return;

        string? error = LayerMedia.HandlePick(this, data, Slot);

        if (error != null)
            Toast.MakeText(this, error, ToastLength.Long)!.Show();

        RefreshMedia();
    }

    private class AppsAdapter : BaseAdapter
    {
        private readonly Context context;
        private readonly List<ResolveInfo> apps;
        private readonly PackageManager pm;

        public AppsAdapter(Context context)
        {
            this.context = context;
            pm = context.PackageManager!;

            var launcherIntent = new Intent(Intent.ActionMain);
            launcherIntent.AddCategory(Intent.CategoryLauncher);

            apps = (pm.QueryIntentActivities(launcherIntent, 0) ?? new List<ResolveInfo>())
                .OrderBy(a => a.LoadLabel(pm)?.ToString() ?? "")
                .Take(40)
                .ToList();
        }

        public override int Count => apps.Count;

        public string? PackageAt(int position)
        {
            return apps[position].ActivityInfo?.PackageName;
        }

        public override Java.Lang.Object? GetItem(int position) => null;

        public override long GetItemId(int position) => position;

        public override View GetView(int position, View? convertView, ViewGroup? parent)
        {
            var info = apps[position];
            var cell = new LinearLayout(context) { Orientation = Orientation.Vertical };
            cell.SetGravity(GravityFlags.CenterHorizontal);

            var icon = new ImageView(context);
            icon.SetImageDrawable(info.LoadIcon(pm));
            cell.AddView(icon, new LinearLayout.LayoutParams(Ui.Dp(context, 48), Ui.Dp(context, 48)));

            var label = new TextView(context) { Text = info.LoadLabel(pm)?.ToString() ?? "", TextSize = 12, Gravity = GravityFlags.Center };
            label.SetTextColor(Color.White);
            label.SetMaxLines(1);
            label.SetShadowLayer(4f, 0f, 0f, Color.Black);
            cell.AddView(label, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WrapContent, ViewGroup.LayoutParams.WrapContent) { TopMargin = Ui.Dp(context, 4) });
            return cell;
        }
    }
}
