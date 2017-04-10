package com.cyparty.laihui.domain;

/**
 * Created by zhu on 2016/8/15.
 */
public class ErrorCode {
    private static final int token_expired=301;
    private static final int error_password=302;
    private static final int login_error=305;

    public static int getToken_expired() {
        return token_expired;
    }

    public static int getError_password() {
        return error_password;
    }

    public static int getLogin_error() {
        return login_error;
    }
}
