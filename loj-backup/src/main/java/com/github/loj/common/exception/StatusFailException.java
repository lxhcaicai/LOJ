package com.github.loj.common.exception;

/**
 * @author lxhcaicai
 * @date 2023/4/24 23:59
 */
public class StatusFailException extends Exception{
    public StatusFailException() {

    }

    public StatusFailException(String message) {
        super(message);
    }

    public StatusFailException(String message, Throwable cause) {
        super(message, cause);
    }

    public StatusFailException(Throwable cause) {
        super(cause);
    }

    public StatusFailException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
