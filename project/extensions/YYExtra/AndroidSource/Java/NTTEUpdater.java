package ${YYAndroidPackageName};

import android.app.Activity;
import android.content.ClipData;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import androidx.core.content.FileProvider;
import com.yoyogames.runner.RunnerJNILib;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Arrays;
import java.util.HashSet;
import java.util.concurrent.atomic.AtomicBoolean;

public final class NTTEUpdater {
    public static final int PERMISSION_CODE = 4874;
    private final AtomicBoolean busy = new AtomicBoolean(false);
    private volatile boolean cancelled;
    private volatile File ready;
    private volatile int generation;

    private Activity activity() { return RunnerActivity.CurrentActivity; }

    private void event(String state, double progress, String error) {
        int map = RunnerJNILib.jCreateDsMap(null, null, null);
        RunnerJNILib.DsMapAddString(map, "type", "ntte_update");
        RunnerJNILib.DsMapAddString(map, "state", state);
        RunnerJNILib.DsMapAddString(map, "error", error);
        RunnerJNILib.DsMapAddDouble(map, "download_id", generation);
        RunnerJNILib.DsMapAddDouble(map, "progress", progress);
        RunnerJNILib.CreateAsynEventWithDSMap(map, 70);
    }

    public double download(final String url, final String hash, final double expectedSize) {
        final long size = (long) expectedSize;
        if (!NTTEUpdatePolicy.assetUrl(url) || !NTTEUpdatePolicy.metadata(hash, size) || size != expectedSize) return -1;
        if (!busy.compareAndSet(false, true)) return -1;
        cancelled = false;
        ready = null;
        final int id = ++generation;
        final File directory = new File(activity().getCacheDir(), "ntte-updates");
        new Thread(new Runnable() {
            public void run() {
                File partial = new File(directory, "update.part");
                File target = new File(directory, "update.apk");
                HttpURLConnection connection = null;
                try {
                    if (!directory.isDirectory() && !directory.mkdirs()) throw new Exception("storage");
                    if (target.exists() && !target.delete()) throw new Exception("storage");
                    if (directory.getUsableSpace() < size + 8388608L) throw new Exception("storage");
                    String current = url;
                    for (int redirects = 0; ; redirects++) {
                        if (cancelled) throw new Exception("cancelled");
                        if (redirects > 5 || !NTTEUpdatePolicy.redirectUrl(current)) throw new Exception("redirect");
                        connection = (HttpURLConnection) new URL(current).openConnection();
                        connection.setInstanceFollowRedirects(false);
                        connection.setConnectTimeout(20000);
                        connection.setReadTimeout(30000);
                        connection.setRequestProperty("User-Agent", "NTTE-Mobile-Port");
                        connection.setRequestProperty("Accept-Encoding", "identity");
                        int status = connection.getResponseCode();
                        if (status == 200) break;
                        if (status == 301 || status == 302 || status == 303 || status == 307 || status == 308) {
                            current = new URL(new URL(current), connection.getHeaderField("Location")).toString();
                            connection.disconnect();
                            continue;
                        }
                        throw new Exception("http_" + status);
                    }
                    event("downloading", 0, "");
                    try (InputStream input = connection.getInputStream(); FileOutputStream output = new FileOutputStream(partial)) {
                        NTTEUpdatePolicy.copyVerified(input, output, size, hash, new NTTEUpdatePolicy.Progress() {
                            long lastEvent;
                            public boolean cancelled() { return cancelled || generation != id; }
                            public void bytes(long count) {
                                long now = android.os.SystemClock.elapsedRealtime();
                                if (now - lastEvent >= 500) { lastEvent = now; event("downloading", 100.0 * count / size, ""); }
                            }
                        });
                        output.getFD().sync();
                    }
                    event("verifying", 100, "");
                    if (cancelled) throw new Exception("cancelled");
                    if (!partial.renameTo(target)) throw new Exception("storage");
                    verifyPackage(target);
                    ready = target;
                    event("ready", 100, "");
                } catch (Exception error) {
                    partial.delete();
                    target.delete();
                    event(cancelled ? "cancelled" : "download_failed", 0, error.getMessage() == null ? "download" : error.getMessage());
                } finally {
                    if (connection != null) connection.disconnect();
                    busy.set(false);
                }
            }
        }, "NTTE-update-download").start();
        return id;
    }

    @SuppressWarnings("deprecation")
    private void verifyPackage(File file) throws Exception {
        PackageManager manager = activity().getPackageManager();
        PackageInfo installed = manager.getPackageInfo(activity().getPackageName(), PackageManager.GET_SIGNATURES);
        PackageInfo incoming = manager.getPackageArchiveInfo(file.getAbsolutePath(), PackageManager.GET_SIGNATURES);
        if (incoming == null || !installed.packageName.equals(incoming.packageName)) throw new Exception("package_mismatch");
        long current = Build.VERSION.SDK_INT >= 28 ? installed.getLongVersionCode() : installed.versionCode;
        long next = Build.VERSION.SDK_INT >= 28 ? incoming.getLongVersionCode() : incoming.versionCode;
        if (next < current) throw new Exception("downgrade");
        if (installed.signatures == null || incoming.signatures == null || installed.signatures.length == 0
            || !new HashSet<Signature>(Arrays.asList(installed.signatures)).equals(new HashSet<Signature>(Arrays.asList(incoming.signatures))))
            throw new Exception("signature_mismatch");
    }

    public double cancel() {
        cancelled = true;
        return 1;
    }

    public double install(final boolean requestPermission) {
        final File file = ready;
        if (file == null || !file.isFile() || busy.get()) return -1;
        activity().runOnUiThread(new Runnable() {
            public void run() {
                try {
                    Activity owner = activity();
                    if (Build.VERSION.SDK_INT >= 26 && !owner.getPackageManager().canRequestPackageInstalls()) {
                        event("permission", 100, "");
                        if (requestPermission) owner.startActivityForResult(new Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES,
                            Uri.parse("package:" + owner.getPackageName())), PERMISSION_CODE);
                        return;
                    }
                    Uri uri = FileProvider.getUriForFile(owner, owner.getPackageName() + ".ntteupdates", file);
                    Intent intent = new Intent(Intent.ACTION_INSTALL_PACKAGE);
                    intent.setDataAndType(uri, "application/vnd.android.package-archive");
                    intent.setClipData(ClipData.newRawUri("NTTE update", uri));
                    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                    intent.putExtra(Intent.EXTRA_NOT_UNKNOWN_SOURCE, true);
                    owner.startActivity(intent);
                    event("installer", 100, "");
                } catch (Exception error) { event("install_failed", 100, "installer"); }
            }
        });
        return 1;
    }
}
