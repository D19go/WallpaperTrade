using Android.App;
using Android.Content;
using System.Security.Cryptography;

namespace wallpaperTrade;

public static class WallpaperChangerService
{
    private const string Prefs = "wallpaper";
    private const string HomeImagesKey = "home_images";
    private const string LockImagesKey = "lock_images";
    private const string HomeIndexKey = "home_index";
    private const string LockIndexKey = "lock_index";
    private const string ModeKey = "mode";
    private const string TargetKey = "target";
    private const string CarouselTargetKey = "carousel_target";
    private const string OldImagesKey = "images";
    private static readonly object SyncLock = new();

    public static bool AddImage(Context context, string fileName)
    {
        return AddImage(context, fileName, true, true);
    }

    public static bool AddImage(Context context, string fileName, bool home, bool lockScreen)
    {
        if (string.IsNullOrWhiteSpace(fileName))
            return false;

        bool added = false;
        var prefs = GetPrefs(context);

        if (home)
        {
            var images = GetHomeImages(context);

            if (!images.Contains(fileName))
            {
                images.Add(fileName);
                SaveImages(prefs, HomeImagesKey, images);
                added = true;
            }
        }

        if (lockScreen)
        {
            var images = GetLockImages(context);

            if (!images.Contains(fileName))
            {
                images.Add(fileName);
                SaveImages(prefs, LockImagesKey, images);
                added = true;
            }
        }

        return added;
    }

    public static List<string> Images(Context context)
    {
        return GetHomeImages(context);
    }

    public static List<string> Images(Context context, bool home)
    {
        return home ? GetHomeImages(context) : GetLockImages(context);
    }

    public static List<string> Images(Context context, string target)
    {
        return target == "lock" ? GetLockImages(context) : GetHomeImages(context);
    }

    public static int Count(Context context)
    {
        return GetHomeImages(context).Count;
    }

    public static int Count(Context context, bool home)
    {
        return home ? GetHomeImages(context).Count : GetLockImages(context).Count;
    }

    public static int Count(Context context, string target)
    {
        return target == "lock" ? GetLockImages(context).Count : GetHomeImages(context).Count;
    }

    public static bool RemoveImage(Context context, string fileName)
    {
        return RemoveImage(context, fileName, true, true);
    }

    public static bool RemoveImage(Context context, string fileName, bool home, bool lockScreen)
    {
        bool removed = false;
        var prefs = GetPrefs(context);

        if (home)
        {
            var images = GetHomeImages(context);

            if (images.Remove(fileName))
            {
                SaveImages(prefs, HomeImagesKey, images);
                NormalizeIndex(prefs, HomeIndexKey, images.Count);
                removed = true;
            }
        }

        if (lockScreen)
        {
            var images = GetLockImages(context);

            if (images.Remove(fileName))
            {
                SaveImages(prefs, LockImagesKey, images);
                NormalizeIndex(prefs, LockIndexKey, images.Count);
                removed = true;
            }
        }

        bool stillUsed = GetHomeImages(context).Contains(fileName) || GetLockImages(context).Contains(fileName);

        if (removed && !stillUsed)
        {
            string path = System.IO.Path.Combine(context.FilesDir!.AbsolutePath, fileName);

            try
            {
                if (File.Exists(path))
                    File.Delete(path);
            }
            catch
            {
            }
        }

        return removed;
    }

    public static bool IsDuplicate(Context context, string filePath)
    {
        return IsDuplicate(context, filePath, true, true);
    }

    public static bool IsDuplicate(Context context, string filePath, bool home, bool lockScreen)
    {
        if (!File.Exists(filePath))
            return false;

        string newHash = GetHash(filePath);

        if (home)
        {
            foreach (string image in GetHomeImages(context))
            {
                string path = System.IO.Path.Combine(context.FilesDir!.AbsolutePath, image);

                if (File.Exists(path) && GetHash(path) == newHash)
                    return true;
            }
        }

        if (lockScreen)
        {
            foreach (string image in GetLockImages(context))
            {
                string path = System.IO.Path.Combine(context.FilesDir!.AbsolutePath, image);

                if (File.Exists(path) && GetHash(path) == newHash)
                    return true;
            }
        }

        return false;
    }

    public static void ClearImages(Context context)
    {
        var prefs = GetPrefs(context);
        var allFiles = new HashSet<string>(GetHomeImages(context).Concat(GetLockImages(context)));

        foreach (string image in allFiles)
        {
            string path = System.IO.Path.Combine(context.FilesDir!.AbsolutePath, image);

            try { File.Delete(path); } catch { }
        }

        prefs.Edit()!.Remove(HomeImagesKey).Remove(LockImagesKey).Remove(OldImagesKey).PutInt(HomeIndexKey, -1).PutInt(LockIndexKey, -1).Apply();
    }

    public static void SetMode(Context context, bool random)
    {
        GetPrefs(context).Edit()!.PutString(ModeKey, random ? "random" : "sequential").Apply();
    }

    public static void SetTarget(Context context, string target)
    {
        if (target != "home" && target != "lock" && target != "both")
            target = "both";

        GetPrefs(context).Edit()!.PutString(TargetKey, target).Apply();
    }

    public static string GetTarget(Context context)
    {
        return GetPrefs(context).GetString(TargetKey, "both") ?? "both";
    }

    public static void SetCarouselTarget(Context context, string target)
    {
        if (target != "home" && target != "lock" && target != "both")
            target = "both";

        GetPrefs(context).Edit()!.PutString(CarouselTargetKey, target).Apply();
    }

    public static string GetCarouselTarget(Context context)
    {
        return GetPrefs(context).GetString(CarouselTargetKey, "both") ?? "both";
    }

    public static void Change(Context context)
    {
        ChangeReliable(context, 1, 0);
    }

    public static bool ChangeReliable(Context context, int attempts = 3, int delayMs = 250)
    {
        if (attempts < 1)
            attempts = 1;

        lock (SyncLock)
        {
            string target = GetPrefs(context).GetString(CarouselTargetKey, "both") ?? "both";
            bool homeChanged = false;
            bool lockChanged = false;

            if (target == "home" || target == "both")
                homeChanged = ChangeListWithRetry(context, true, attempts, delayMs);

            if (target == "lock" || target == "both")
                lockChanged = ChangeListWithRetry(context, false, attempts, delayMs);

            return homeChanged || lockChanged;
        }
    }

    public static void ChangeHome(Context context)
    {
        lock (SyncLock)
            ChangeListWithRetry(context, true, 1, 0);
    }

    public static void ChangeLock(Context context)
    {
        lock (SyncLock)
            ChangeListWithRetry(context, false, 1, 0);
    }

    private static bool ChangeListWithRetry(Context context, bool home, int attempts, int delayMs)
    {
        for (int attempt = 0; attempt < attempts; attempt++)
        {
            if (ChangeList(context, home))
                return true;

            if (attempt + 1 < attempts && delayMs > 0)
                Thread.Sleep(delayMs);
        }

        return false;
    }

    private static bool ChangeList(Context context, bool home)
    {
        var prefs = GetPrefs(context);
        var images = home ? GetHomeImages(context) : GetLockImages(context);

        if (images.Count == 0)
            return false;

        string indexKey = home ? HomeIndexKey : LockIndexKey;
        int index = GetNextIndex(prefs, indexKey, images.Count);

        if (index < 0 || index >= images.Count)
            return false;

        string path = System.IO.Path.Combine(context.FilesDir!.AbsolutePath, images[index]);

        if (!File.Exists(path))
        {
            images.RemoveAt(index);
            SaveImages(prefs, home ? HomeImagesKey : LockImagesKey, images);
            NormalizeIndex(prefs, indexKey, images.Count);
            return false;
        }

        try
        {
            using var stream = File.OpenRead(path);
            WallpaperManagerFlags target = home ? WallpaperManagerFlags.System : WallpaperManagerFlags.Lock;
            WallpaperManager.GetInstance(context).SetStream(stream, null, true, target);
            prefs.Edit()!.PutInt(indexKey, index).Apply();
            return true;
        }
        catch
        {
            return false;
        }
    }

    private static int GetNextIndex(ISharedPreferences prefs, string indexKey, int count)
    {
        if (count <= 0)
            return -1;

        int current = prefs.GetInt(indexKey, -1);
        string mode = prefs.GetString(ModeKey, "sequential") ?? "sequential";

        if (mode == "random")
        {
            if (count == 1)
                return 0;

            int next;

            do
            {
                next = Random.Shared.Next(count);
            }
            while (next == current);

            return next;
        }

        return (current + 1) % count;
    }

    private static void NormalizeIndex(ISharedPreferences prefs, string indexKey, int count)
    {
        int current = prefs.GetInt(indexKey, -1);

        if (count <= 0 || current >= count)
            prefs.Edit()!.PutInt(indexKey, -1).Apply();
    }

    private static List<string> GetHomeImages(Context context)
    {
        EnsureMigration(context);
        return GetImages(context, HomeImagesKey);
    }

    private static List<string> GetLockImages(Context context)
    {
        EnsureMigration(context);
        return GetImages(context, LockImagesKey);
    }

    private static List<string> GetImages(Context context, string key)
    {
        string data = GetPrefs(context).GetString(key, "") ?? "";

        return data.Split('|', StringSplitOptions.RemoveEmptyEntries).Where(file => File.Exists(System.IO.Path.Combine(context.FilesDir!.AbsolutePath, file))).Distinct().ToList();
    }

    private static void SaveImages(ISharedPreferences prefs, string key, List<string> images)
    {
        prefs.Edit()!.PutString(key, string.Join("|", images)).Apply();
    }

    private static void EnsureMigration(Context context)
    {
        var prefs = GetPrefs(context);
        string home = prefs.GetString(HomeImagesKey, "") ?? "";
        string lockList = prefs.GetString(LockImagesKey, "") ?? "";

        if (!string.IsNullOrWhiteSpace(home) || !string.IsNullOrWhiteSpace(lockList))
            return;

        string old = prefs.GetString(OldImagesKey, "") ?? "";

        if (string.IsNullOrWhiteSpace(old))
            return;

        var oldImages = old.Split('|', StringSplitOptions.RemoveEmptyEntries).Distinct().Where(file => File.Exists(System.IO.Path.Combine(context.FilesDir!.AbsolutePath, file))).ToList();

        if (oldImages.Count == 0)
            return;

        SaveImages(prefs, HomeImagesKey, oldImages);
        SaveImages(prefs, LockImagesKey, oldImages);
    }

    private static string GetHash(string path)
    {
        using var stream = File.OpenRead(path);
        return Convert.ToHexString(SHA256.HashData(stream));
    }

    private static ISharedPreferences GetPrefs(Context context)
    {
        return context.GetSharedPreferences(Prefs, FileCreationMode.Private);
    }
}
