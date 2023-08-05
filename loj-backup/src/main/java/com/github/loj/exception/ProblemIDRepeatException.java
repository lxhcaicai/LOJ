package com.github.loj.exception;

public class ProblemIDRepeatException extends RuntimeException{
    public ProblemIDRepeatException() {
        super();
    }

    protected ProblemIDRepeatException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }

    public ProblemIDRepeatException(String message) {
        super(message);
    }

    public ProblemIDRepeatException(String message, Throwable cause) {
        super(message, cause);
    }

    public ProblemIDRepeatException(Throwable cause) {
        super(cause);
    }
}
