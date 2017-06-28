package com.cyparty.laihui.utilities;

/**
 * Created by zhu on 2016/10/27.
 */
public class ConfigUtils {
    private static final int show_days=6;//显示7天内的数据变化情况

    public static  final  String SUB_ADMIN = "laihui_sx";

    //极光推送离线时长 单位:秒
    public static final long TIME_TO_LIVE = 1800;
    //极光环境 false测试 true正式
    public static final boolean JPUSH_PROD = false;
    //极光AppKey
    public static final String JPUSH_APP_KEY = "bdc7c59bbaba335fe3593f1f";
    //极光秘钥
    public static final String JPUSH_MASTER_SECRET = "bd73a921b52dad9447262d5f";

    public static int getShow_days() {
        return show_days;
    }
}
