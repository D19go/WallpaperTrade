using Android.App;
using Android.Content;
using Android.Graphics;
using Android.Net;
using Android.OS;
using Android.Provider;
using Android.Views;
using Android.Widget;

namespace wallpaperTrade;

[Activity(MainLauncher = true, Exported = true, Label = "Wallpaper Trade")]
public class MainActivity : Activity
{
    private const int PickImages = 100;
    private const string MainPrefs = "wallpaper_main";
    private const string BatteryPromptKey = "battery_prompt_shown";
    private TextView? status;
    private RadioGroup? targetGroup;
    private RadioGroup? carouselTargetGroup;

    protected override void AttachBaseContext(Context? @base)
    {
        base.AttachBaseContext(@base == null ? null : ThemeManager.Wrap(@base));
    }

    protected override void OnCreate(Bundle? savedInstanceState)
    {
        base.OnCreate(savedInstanceState);
        SetContentView(Resource.Layout.activity_main);

        var root = FindViewById<View>(Resource.Id.root)!;
        var selectButton = FindViewById<Button>(Resource.Id.selectButton)!;
        var changeButton = FindViewById<Button>(Resource.Id.changeButton)!;
        var clearButton = FindViewById<Button>(Resource.Id.clearButton)!;
        var automaticSwitch = FindViewById<Switch>(Resource.Id.automaticSwitch)!;
        var modeGroup = FindViewById<RadioGroup>(Resource.Id.modeGroup)!;

        targetGroup = FindViewById<RadioGroup>(Resource.Id.targetGroup);
        carouselTargetGroup = FindViewById<RadioGroup>(Resource.Id.carouselTargetGroup);
        status = FindViewById<TextView>(Resource.Id.status);

        root.SetOnApplyWindowInsetsListener(new InsetsListener());

        selectButton.Click += (_, _) => PickPhotos();
        changeButton.Click += (_, _) => WallpaperChangerService.ChangeReliable(this);
        FindViewById<Button>(Resource.Id.liveButton)!.Click += (_, _) => ActivateLiveWallpaper();
        FindViewById<Button>(Resource.Id.staticButton)!.Click += (_, _) => BackToStaticWallpaper();

        clearButton.Click += (_, _) =>
        {
            WallpaperChangerService.ClearImages(this);
            UpdateStatus();
            UpdateGallery();
        };

        modeGroup.CheckedChange += (_, e) => WallpaperChangerService.SetMode(this, e.CheckedId == Resource.Id.randomRadio);

        if (targetGroup != null)
        {
            targetGroup.CheckedChange += (_, e) =>
            {
                string target = e.CheckedId switch
                {
                    Resource.Id.systemRadio => "home",
                    Resource.Id.lockRadio => "lock",
                    _ => "both"
                };

                WallpaperChangerService.SetTarget(this, target);
            };
        }

        if (carouselTargetGroup != null)
        {
            carouselTargetGroup.CheckedChange += (_, e) =>
            {
                string target = e.CheckedId switch
                {
                    Resource.Id.carouselHomeRadio => "home",
                    Resource.Id.carouselLockRadio => "lock",
                    _ => "both"
                };

                WallpaperChangerService.SetCarouselTarget(this, target);
            };
        }

        SetTargetRadioButtons();
        SetCarouselTargetRadioButtons();
        SetupThemeGroup();

        automaticSwitch.CheckedChange += (_, e) => SetAutomatic(e.IsChecked);

        bool automaticEnabled = WallpaperMonitorService.IsAutomaticEnabled(this);
        automaticSwitch.Checked = automaticEnabled;

        if (automaticEnabled)
        {
            StartAutomaticService();
            RequestBatteryOptimizationExemption();
        }

        UpdateStatus();
        UpdateGallery();
    }

    protected override void OnResume()
    {
        base.OnResume();

        if (WallpaperMonitorService.IsAutomaticEnabled(this))
            StartAutomaticService();

        UpdateStatus(); // o usuário pode ter ativado o papel animado no diálogo do sistema
    }

    // GIFs só rodam como papel de parede animado: o Android pede a confirmação do usuário uma vez.
    // Cada fabricante trata isso de um jeito, então tenta várias formas, da mais direta à mais genérica.
    private void ActivateLiveWallpaper()
    {
        var errors = new List<string>();

        var attempts = new List<(string Name, Func<Intent> Build)>
        {
            // 1) Abre a confirmação já apontando para o nosso serviço.
            ("confirmação direta", () =>
            {
                var i = new Intent(WallpaperManager.ActionChangeLiveWallpaper);
                i.PutExtra(WallpaperManager.ExtraLiveWallpaperComponent, GifWallpaperService.Component(this));
                return i;
            }),
            // 2) Lista de papéis de parede animados do sistema.
            ("lista de papéis animados", () => new Intent(WallpaperManager.ActionLiveWallpaperChooser)),
            // 3) Seletor de papéis de parede genérico (existe em quase todo aparelho).
            ("seletor de papéis de parede", () => Intent.CreateChooser(new Intent(Intent.ActionSetWallpaper), "Escolher papel de parede")!),
        };

        foreach (var (name, build) in attempts)
        {
            try
            {
                var intent = build();

                if (intent.ResolveActivity(PackageManager!) == null && name != "seletor de papéis de parede")
                {
                    errors.Add($"{name}: nenhum app do aparelho abre isso");
                    continue;
                }

                StartActivity(intent);

                if (name != "confirmação direta")
                    ShowError("Procure por \"Wallpaper Trade (animado)\" na lista e toque em Definir.");

                return;
            }
            catch (Exception ex)
            {
                errors.Add($"{name}: {ex.GetType().Name} - {ex.Message}");
            }
        }

        // Nada funcionou: mostra tudo, para dar para diagnosticar.
        new AlertDialog.Builder(this)!
            .SetTitle("Este aparelho não abre a escolha de papel animado")!
            .SetMessage(
                "Diagnóstico:\n" + BuildLiveWallpaperDiagnostics() +
                "\n\nSem essa tela do sistema, o Android não deixa o app ativar o papel animado sozinho. " +
                "Os GIFs continuam funcionando na troca automática, mas como imagem parada (primeiro quadro).\n\n" +
                "Erros:\n" + string.Join("\n", errors))!
            .SetPositiveButton("OK", (EventHandler<DialogClickEventArgs>?)null)!
            .Show();
    }

    // Resumo do que o aparelho oferece para papéis animados (para saber se é limitação do aparelho).
    private string BuildLiveWallpaperDiagnostics()
    {
        var pm = PackageManager!;
        string feature = pm.HasSystemFeature("android.software.live_wallpaper") ? "sim" : "não";

        string Handler(Intent i) => i.ResolveActivity(pm) != null ? "existe" : "não existe";

        var direct = new Intent(WallpaperManager.ActionChangeLiveWallpaper);
        var chooser = new Intent(WallpaperManager.ActionLiveWallpaperChooser);
        var setWallpaper = new Intent(Intent.ActionSetWallpaper);

        return $"Aparelho: {Build.Manufacturer} {Build.Model}\n" +
               $"Android: {Build.VERSION.Release} (API {(int)Build.VERSION.SdkInt})\n" +
               $"Declara suporte a papel animado: {feature}\n" +
               $"Tela de confirmação: {Handler(direct)}\n" +
               $"Lista de papéis animados: {Handler(chooser)}\n" +
               $"Seletor de papéis de parede: {Handler(setWallpaper)}";
    }

    private void BackToStaticWallpaper()
    {
        try
        {
            WallpaperManager.GetInstance(this)?.Clear();
        }
        catch (Exception ex)
        {
            ShowError($"Erro ao desativar o modo animado:\n{ex.Message}");
        }

        WallpaperChangerService.ChangeReliable(this);
        UpdateStatus();
    }

    private void SetAutomatic(bool enabled)
    {
        WallpaperMonitorService.SetAutomaticEnabled(this, enabled);

        if (enabled)
        {
            StartAutomaticService();
            RequestBatteryOptimizationExemption();
        }
        else
        {
            StopService(new Intent(this, typeof(WallpaperMonitorService)));
        }
    }

    private void StartAutomaticService()
    {
        try
        {
            var intent = new Intent(this, typeof(WallpaperMonitorService));

            if (Build.VERSION.SdkInt >= BuildVersionCodes.O)
                StartForegroundService(intent);
            else
                StartService(intent);
        }
        catch (Exception ex)
        {
            ShowError($"Não foi possível iniciar a troca automática:\n{ex.Message}");
        }
    }

    private void RequestBatteryOptimizationExemption()
    {
        if (Build.VERSION.SdkInt < BuildVersionCodes.M)
            return;

        try
        {
            var powerManager = GetSystemService(PowerService) as PowerManager;

            if (powerManager == null || powerManager.IsIgnoringBatteryOptimizations(PackageName))
                return;

            var prefs = GetSharedPreferences(MainPrefs, FileCreationMode.Private)!;

            if (prefs.GetBoolean(BatteryPromptKey, false))
                return;

            prefs.Edit()!.PutBoolean(BatteryPromptKey, true).Apply();

            var intent = new Intent(Settings.ActionRequestIgnoreBatteryOptimizations);
            intent.SetData(Android.Net.Uri.Parse($"package:{PackageName}"));
            StartActivity(intent);
        }
        catch
        {
        }
    }

    private void SetTargetRadioButtons()
    {
        if (targetGroup == null)
            return;

        string target = WallpaperChangerService.GetTarget(this);

        targetGroup.Check(target switch
        {
            "home" => Resource.Id.systemRadio,
            "lock" => Resource.Id.lockRadio,
            _ => Resource.Id.bothRadio
        });
    }

    private void SetCarouselTargetRadioButtons()
    {
        if (carouselTargetGroup == null)
            return;

        string target = WallpaperChangerService.GetCarouselTarget(this);

        carouselTargetGroup.Check(target switch
        {
            "home" => Resource.Id.carouselHomeRadio,
            "lock" => Resource.Id.carouselLockRadio,
            _ => Resource.Id.carouselBothRadio
        });
    }

    private void SetupThemeGroup()
    {
        var themeGroup = FindViewById<RadioGroup>(Resource.Id.themeGroup);

        if (themeGroup == null)
            return;

        themeGroup.Check(ThemeManager.GetMode(this) switch
        {
            ThemeManager.ModeLight => Resource.Id.themeLightRadio,
            ThemeManager.ModeDark => Resource.Id.themeDarkRadio,
            _ => Resource.Id.themeSystemRadio
        });

        themeGroup.CheckedChange += (_, e) =>
        {
            string mode = e.CheckedId switch
            {
                Resource.Id.themeLightRadio => ThemeManager.ModeLight,
                Resource.Id.themeDarkRadio => ThemeManager.ModeDark,
                _ => ThemeManager.ModeSystem
            };

            if (mode == ThemeManager.GetMode(this))
                return;

            ThemeManager.SetMode(this, mode);
            Recreate();
        };
    }

    private void PickPhotos()
    {
        // GetContent com image/* + image/gif: mostra galeria, Fotos e arquivos, inclusive GIFs
        // (o ActionPick sobre o MediaStore, usado antes, esconde GIFs em vários aparelhos).
        var intent = new Intent(Intent.ActionGetContent);
        intent.SetType("image/*");
        intent.AddCategory(Intent.CategoryOpenable);
        intent.PutExtra(Intent.ExtraMimeTypes, new[] { "image/jpeg", "image/png", "image/webp", "image/gif", "image/heic", "image/heif" });
        intent.PutExtra(Intent.ExtraAllowMultiple, true);
        StartActivityForResult(Intent.CreateChooser(intent, "Selecionar imagens"), PickImages);
    }

    protected override void OnActivityResult(int requestCode, Result resultCode, Intent? data)
    {
        base.OnActivityResult(requestCode, resultCode, data);

        if (requestCode != PickImages || resultCode != Result.Ok || data == null)
            return;

        bool addHome = targetGroup?.CheckedRadioButtonId == Resource.Id.systemRadio;
        bool addLock = targetGroup?.CheckedRadioButtonId == Resource.Id.lockRadio;
        bool addBoth = targetGroup?.CheckedRadioButtonId == Resource.Id.bothRadio;

        if (!addHome && !addLock && !addBoth)
            addBoth = true;

        if (addBoth)
        {
            addHome = true;
            addLock = true;
        }

        int added = 0;
        int duplicated = 0;
        int failed = 0;

        if (data.ClipData != null)
        {
            for (int i = 0; i < data.ClipData.ItemCount; i++)
            {
                var uri = data.ClipData.GetItemAt(i).Uri;

                if (uri == null)
                {
                    failed++;
                    continue;
                }

                int result = SaveSelectedFile(uri, addHome, addLock);

                if (result == 1)
                    added++;
                else if (result == 2)
                    duplicated++;
                else
                    failed++;
            }
        }
        else if (data.Data != null)
        {
            int result = SaveSelectedFile(data.Data, addHome, addLock);

            if (result == 1)
                added++;
            else if (result == 2)
                duplicated++;
            else
                failed++;
        }

        UpdateStatus(added, duplicated, failed);
        UpdateGallery();
    }

    private int SaveSelectedFile(Android.Net.Uri uri, bool addHome, bool addLock)
    {
        try
        {
            string mime = ContentResolver!.GetType(uri) ?? "";
            string? displayName = GetDisplayName(uri);

            bool isGif = mime.Equals("image/gif", StringComparison.OrdinalIgnoreCase) || (displayName?.EndsWith(".gif", StringComparison.OrdinalIgnoreCase) ?? false);

            return SaveImage(uri, addHome, addLock, isGif);
        }
        catch (Exception ex)
        {
            ShowError($"Erro ao importar:\n{ex.Message}");
            return 0;
        }
    }

    private int SaveImage(Android.Net.Uri uri, bool addHome, bool addLock, bool isGif)
    {
        string fileName = $"wallpaper_{Guid.NewGuid():N}.{(isGif ? "gif" : "jpg")}";
        string path = System.IO.Path.Combine(FilesDir!.AbsolutePath, fileName);

        try
        {
            using var input = ContentResolver!.OpenInputStream(uri);

            if (input == null)
            {
                ShowError("Não foi possível abrir a imagem.");
                return 0;
            }

            using (var output = OpenFileOutput(fileName, FileCreationMode.Private))
            {
                input.CopyTo(output);
                output.Flush();
            }

            // Nem todo seletor informa o tipo/nome certo: confere pelo conteúdo do arquivo.
            if (!isGif && File.Exists(path) && ImageHelper.IsGif(path))
            {
                string gifName = System.IO.Path.ChangeExtension(fileName, ".gif");
                string gifPath = System.IO.Path.Combine(FilesDir!.AbsolutePath, gifName);
                File.Move(path, gifPath);
                fileName = gifName;
                path = gifPath;
            }

            if (!File.Exists(path))
            {
                ShowError("A imagem não foi criada.");
                return 0;
            }

            if (WallpaperChangerService.IsDuplicate(this, path, addHome, addLock))
            {
                File.Delete(path);
                return 2;
            }

            if (!WallpaperChangerService.AddImage(this, fileName, addHome, addLock))
            {
                File.Delete(path);
                return 0;
            }

            return 1;
        }
        catch (Exception ex)
        {
            try
            {
                if (File.Exists(path))
                    File.Delete(path);
            }
            catch
            {
            }

            ShowError($"Erro ao importar:\n{ex.Message}");
            return 0;
        }
    }

    private string? GetDisplayName(Android.Net.Uri uri)
    {
        try
        {
            using var cursor = ContentResolver!.Query(uri, null, null, null, null);

            if (cursor == null)
                return null;

            int index = cursor.GetColumnIndex(MediaStore.IMediaColumns.DisplayName);

            if (index < 0 || !cursor.MoveToFirst())
                return null;

            return cursor.GetString(index);
        }
        catch
        {
            return null;
        }
    }

    private void ShowError(string message)
    {
        Toast.MakeText(this, message, ToastLength.Long)!.Show();
    }

    private void UpdateStatus(int added = 0, int duplicated = 0, int failed = 0)
    {
        int homeCount = WallpaperChangerService.Count(this, "home");
        int lockCount = WallpaperChangerService.Count(this, "lock");

        string live = GifWallpaperService.IsActive(this, true) ? "ativo" : "inativo";

        if (added == 0 && duplicated == 0 && failed == 0)
        {
            status!.Text = $"Tela inicial: {homeCount}\nTela de bloqueio: {lockCount}\nPapel animado (GIF): {live}";
            return;
        }

        status!.Text = $"{added} imagem(ns) adicionada(s)";

        if (duplicated > 0)
            status.Text += $"\n{duplicated} duplicada(s) ignorada(s)";

        if (failed > 0)
            status.Text += $"\n{failed} falha(s) ao importar";

        status.Text += $"\n\nTela inicial: {homeCount}\nTela de bloqueio: {lockCount}\nPapel animado (GIF): {live}";
    }

    private void UpdateGallery()
    {
        var homeGallery = FindViewById<GridLayout>(Resource.Id.homeGallery);
        var lockGallery = FindViewById<GridLayout>(Resource.Id.lockGallery);

        homeGallery?.RemoveAllViews();
        lockGallery?.RemoveAllViews();

        if (homeGallery != null)
        {
            foreach (string fileName in WallpaperChangerService.Images(this, "home"))
                AddGalleryItem(homeGallery, fileName, "home");
        }

        if (lockGallery != null)
        {
            foreach (string fileName in WallpaperChangerService.Images(this, "lock"))
                AddGalleryItem(lockGallery, fileName, "lock");
        }
    }

    private void AddGalleryItem(GridLayout gallery, string fileName, string target)
    {
        string path = System.IO.Path.Combine(FilesDir!.AbsolutePath, fileName);

        if (!File.Exists(path))
            return;

        var item = new LinearLayout(this) { Orientation = Orientation.Vertical };

        int margin = Dp(6);

        var itemParams = new GridLayout.LayoutParams
        {
            Width = 0,
            Height = ViewGroup.LayoutParams.WrapContent,
            ColumnSpec = GridLayout.InvokeSpec(GridLayout.Undefined, 1f)
        };

        itemParams.SetMargins(margin, margin, margin, margin);
        item.LayoutParameters = itemParams;

        var image = new ImageView(this);
        image.SetImageBitmap(LoadThumbnail(path));
        image.SetScaleType(ImageView.ScaleType.CenterCrop);
        image.LayoutParameters = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MatchParent, Dp(180));
        item.AddView(image);

        if (ImageHelper.IsGif(path))
            item.AddView(new TextView(this) { Text = "GIF animado", Gravity = GravityFlags.Center });

        var delete = new Button(this) { Text = "Excluir" };

        delete.Click += (_, _) =>
        {
            bool fromHome = target == "home";
            bool fromLock = target == "lock";

            WallpaperChangerService.RemoveImage(this, fileName, fromHome, fromLock);

            UpdateStatus();
            UpdateGallery();
        };

        item.AddView(delete);
        gallery.AddView(item);
    }

    private Bitmap? LoadThumbnail(string path)
    {
        return ImageHelper.LoadThumbnail(path, 600);
    }

    private int Dp(int value)
    {
        return (int)(value * Resources!.DisplayMetrics!.Density);
    }

    private class InsetsListener : Java.Lang.Object, View.IOnApplyWindowInsetsListener
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