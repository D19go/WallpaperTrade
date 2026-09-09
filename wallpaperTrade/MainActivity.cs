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

    private void PickPhotos()
    {
        var intent = new Intent(Intent.ActionPick);
        intent.SetDataAndType(MediaStore.Images.Media.ExternalContentUri, "image/*");
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

            if (isGif)
            {
                ShowError("GIF não é suportado nesta versão. Selecione JPG ou PNG.");
                return 0;
            }

            return SaveImage(uri, addHome, addLock);
        }
        catch (Exception ex)
        {
            ShowError($"Erro ao importar:\n{ex.Message}");
            return 0;
        }
    }

    private int SaveImage(Android.Net.Uri uri, bool addHome, bool addLock)
    {
        string fileName = $"wallpaper_{Guid.NewGuid():N}.jpg";
        string path = System.IO.Path.Combine(FilesDir!.AbsolutePath, fileName);

        try
        {
            using var input = ContentResolver!.OpenInputStream(uri);

            if (input == null)
            {
                ShowError("Não foi possível abrir a imagem.");
                return 0;
            }

            using var output = OpenFileOutput(fileName, FileCreationMode.Private);
            input.CopyTo(output);
            output.Flush();

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

        if (added == 0 && duplicated == 0 && failed == 0)
        {
            status!.Text = $"Tela inicial: {homeCount}\nTela de bloqueio: {lockCount}";
            return;
        }

        status!.Text = $"{added} imagem(ns) adicionada(s)";

        if (duplicated > 0)
            status.Text += $"\n{duplicated} duplicada(s) ignorada(s)";

        if (failed > 0)
            status.Text += $"\n{failed} falha(s) ao importar";

        status.Text += $"\n\nTela inicial: {homeCount}\nTela de bloqueio: {lockCount}";
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
        var options = new BitmapFactory.Options { InJustDecodeBounds = true };

        BitmapFactory.DecodeFile(path, options);

        options.InSampleSize = CalculateSample(options.OutWidth, options.OutHeight);
        options.InJustDecodeBounds = false;

        return BitmapFactory.DecodeFile(path, options);
    }

    private int CalculateSample(int width, int height)
    {
        int sample = 1;

        while (width / sample > 600 || height / sample > 600)
            sample *= 2;

        return sample;
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