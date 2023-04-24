package com.github.loj.common.exception;

/**
 * @author lxhcaicai
 * @date 2023/4/25 0:15
 */
public class StatusAccessDeniedException extends Exception{
    public StatusAccessDeniedException() {
    }

    public StatusAccessDeniedException(String message) {
        super(message);
    }

    public StatusAccessDeniedException(String message, Throwable cause) {
        super(message, cause);
    }

    public StatusAccessDeniedException(Throwable cause) {
        super(cause);
    }

    public StatusAccessDeniedException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
