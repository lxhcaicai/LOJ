package com.github.loj.common.exception;

import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/4/14 0:26
 */
@Data
public class SystemError extends Exception{
    private String message;
    private String stdout;
    private String stderr;

    public SystemError(String message, String stdout, String stderr) {
        super(message + " " + stderr);
        this.message = message;
        this.stdout = stdout;
        this.stderr = stderr;
    }
}
