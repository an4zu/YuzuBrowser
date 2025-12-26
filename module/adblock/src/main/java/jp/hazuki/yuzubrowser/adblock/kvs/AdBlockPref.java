package jp.hazuki.yuzubrowser.adblock.kvs;

import android.content.Context;

public class AdBlockPref {

    private static final String TABLE = "abp";

    private static final String KEY_NEXT_UPDATE = "abpNextUpdateTime";
    private static final String KEY_LAST_UPDATE = "abpLastUpdateTime";

    private final KvsPreferences kvs;

    public AdBlockPref(Context context) {
        kvs = new KvsPreferences(context, TABLE);
    }

    public long getNextUpdateTime() {
        return kvs.getLong(KEY_NEXT_UPDATE, -1L);
    }

    public void setNextUpdateTime(long value) {
        kvs.putLong(KEY_NEXT_UPDATE, value);
    }

    public long getLastUpdateTime() {
        return kvs.getLong(KEY_LAST_UPDATE, -1L);
    }

    public void setLastUpdateTime(long value) {
        kvs.putLong(KEY_LAST_UPDATE, value);
    }
}
