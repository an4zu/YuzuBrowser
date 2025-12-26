package jp.hazuki.yuzubrowser.adblock.kvs;

import android.content.Context;
import android.content.SharedPreferences;

public class KvsPreferences {

    private final SharedPreferences prefs;

    public KvsPreferences(Context context, String tableName) {
        this.prefs = context.getSharedPreferences(tableName, Context.MODE_PRIVATE);
    }

    public long getLong(String key, long def) {
        return prefs.getLong(key, def);
    }

    public void putLong(String key, long value) {
        prefs.edit().putLong(key, value).apply();
    }
}
