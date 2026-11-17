using Android.App;
using Android.Content;
using Android.Graphics;
using Android.OS;
using Android.Views;
using Android.Widget;

namespace wallpaperTrade;

// Base de todas as telas do app: aplica o tema escolhido e mostra, no canto superior direito,
// um ícone que abre a lista de telas (a tela de troca de papel de parede e os três métodos de camada).
public abstract class ScreenActivity : Activity
{
    private static readonly (string Title, Type ActivityType)[] Screens =
    {
        ("Papel de parede (troca automática)", typeof(MainActivity)),
        ("Método 1: Overlay sobre os apps", typeof(OverlayActivity)),
        ("Método 2: Camada no launcher", typeof(LauncherLayerActivity)),
        ("Método 3: Widget", typeof(WidgetActivity)),
    };

    protected override void AttachBaseContext(Context? @base)
    {
        base.AttachBaseContext(@base == null ? null : ThemeManager.Wrap(@base));
    }

    public override bool OnCreateOptionsMenu(IMenu? menu)
    {
        MenuInflater.Inflate(Resource.Menu.menu_screens, menu);

        var actionView = menu?.FindItem(Resource.Id.screensItem)?.ActionView;

        if (actionView != null)
            actionView.Click += (_, _) => ShowScreenSwitcher();

        return true;
    }

    public override bool OnOptionsItemSelected(IMenuItem item)
    {
        if (item.ItemId == Resource.Id.screensItem)
        {
            ShowScreenSwitcher();
            return true;
        }

        return base.OnOptionsItemSelected(item);
    }

    private void ShowScreenSwitcher()
    {
        var titles = new string[Screens.Length];

        for (int i = 0; i < Screens.Length; i++)
            titles[i] = (Screens[i].ActivityType == GetType() ? "✓  " : "     ") + Screens[i].Title;

        new AlertDialog.Builder(this)!
            .SetTitle("Trocar de tela")!
            .SetItems(titles, (_, e) => OpenScreen(Screens[e.Which].ActivityType))!
            .Show();
    }

    private void OpenScreen(Type target)
    {
        if (target == GetType())
            return;

        var intent = new Intent(this, target);

        // A tela principal é a base da pilha: voltar a ela fecha as outras telas.
        if (target == typeof(MainActivity))
            intent.AddFlags(ActivityFlags.ClearTop | ActivityFlags.SingleTop);

        StartActivity(intent);

        if (this is not MainActivity && target != typeof(MainActivity))
            Finish();
    }

    // Mesmo ajuste de margens das barras do sistema usado na tela principal.
    protected static void ApplyInsets(View root)
    {
        root.SetOnApplyWindowInsetsListener(new BarsInsetsListener());
    }

    private class BarsInsetsListener : Java.Lang.Object, View.IOnApplyWindowInsetsListener
    {
        public WindowInsets OnApplyWindowInsets(View? view, WindowInsets? insets)
        {
            if (view == null || insets == null)
                return insets!;

            if (Build.VERSION.SdkInt >= BuildVersionCodes.R)
            {
                var bars = insets.GetInsets(WindowInsets.Type.SystemBars());
                view.SetPadding(bars.Left, bars.Top, bars.Right, bars.Bottom);
            }

            return insets;
        }
    }
}

// Pequenos atalhos para montar as telas em código.
public static class Ui
{
    public static int Dp(Context context, float value)
    {
        return (int)(value * context.Resources!.DisplayMetrics!.Density + 0.5f);
    }

    public static TextView Label(Context context, string text, float sizeSp = 16, bool bold = false, int topMarginDp = 12)
    {
        var view = new TextView(context) { Text = text, TextSize = sizeSp };

        if (bold)
            view.SetTypeface(null, TypefaceStyle.Bold);

        view.LayoutParameters = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.WrapContent)
        {
            TopMargin = Dp(context, topMarginDp),
        };

        return view;
    }

    public static Button ActionButton(Context context, string text, Action onClick)
    {
        var button = new Button(context) { Text = text };
        button.LayoutParameters = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.WrapContent)
        {
            TopMargin = Dp(context, 10),
        };
        button.Click += (_, _) => onClick();
        return button;
    }

    // Página rolável: devolve a raiz e a coluna onde os itens são adicionados.
    public static FrameLayout Page(Context context, out LinearLayout content)
    {
        var root = new FrameLayout(context);
        var scroll = new ScrollView(context);
        content = new LinearLayout(context) { Orientation = Orientation.Vertical };
        content.SetPadding(Dp(context, 24), Dp(context, 24), Dp(context, 24), Dp(context, 24));
        scroll.AddView(content, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.WrapContent));
        root.AddView(scroll, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MatchParent, ViewGroup.LayoutParams.MatchParent));
        return root;
    }
}
