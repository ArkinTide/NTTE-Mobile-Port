package ${YYAndroidPackageName};

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
import java.security.MessageDigest;
import java.util.Locale;

/** Pure Java download policy, shared by the device implementation and host tests. */
public final class NTTEUpdatePolicy {
    public interface Progress {
        boolean cancelled();
        void bytes(long count);
    }

    public static boolean assetUrl(String value) {
        try {
            URI uri = new URI(value);
            return "https".equals(uri.getScheme()) && "github.com".equals(uri.getHost())
                && uri.getUserInfo() == null && uri.getPort() == -1 && uri.getQuery() == null && uri.getFragment() == null
                && uri.getRawPath().matches("/ArkinTide/NTTE-Mobile-Port/releases/download/((?:0|[1-9][0-9]{0,6})[.](?:0|[1-9][0-9]{0,6})[.](?:0|[1-9][0-9]{0,6}))/NuclearThrone[.]TerritorialExpansion-Android-\\1[.]apk");
        } catch (Exception error) { return false; }
    }

    public static boolean redirectUrl(String value) {
        try {
            URI uri = new URI(value);
            String host = uri.getHost();
            return "https".equals(uri.getScheme()) && uri.getUserInfo() == null && uri.getPort() == -1
                && ("github.com".equals(host) || "release-assets.githubusercontent.com".equals(host)
                    || "objects.githubusercontent.com".equals(host));
        } catch (Exception error) { return false; }
    }

    public static boolean metadata(String hash, long size) {
        return hash != null && hash.matches("[a-fA-F0-9]{64}") && size > 0 && size <= 2147483648L;
    }

    public static void copyVerified(InputStream input, OutputStream output, long size, String hash, Progress progress) throws Exception {
        if (!metadata(hash, size)) throw new IOException("invalid_metadata");
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] buffer = new byte[65536];
        long count = 0;
        for (int read; (read = input.read(buffer)) != -1;) {
            if (progress.cancelled()) throw new IOException("cancelled");
            count += read;
            if (count > size) throw new IOException("size_mismatch");
            output.write(buffer, 0, read);
            digest.update(buffer, 0, read);
            progress.bytes(count);
        }
        if (progress.cancelled()) throw new IOException("cancelled");
        if (count != size) throw new IOException("size_mismatch");
        StringBuilder actual = new StringBuilder();
        for (byte b : digest.digest()) actual.append(String.format(Locale.ROOT, "%02x", b & 255));
        if (!actual.toString().equalsIgnoreCase(hash)) throw new IOException("hash_mismatch");
        output.flush();
    }
}
