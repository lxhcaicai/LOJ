package com.github.loj.common.exception;

import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/4/14 0:23
 */
@Data
public class RuntimeError extends Exception{
    private String message;
    private String stdout;
    private String stderr;

    public RuntimeError(String message, String message1, String stdout, String stderr) {
        super(message);
        this.message = message1;
        this.stdout = stdout;
        this.stderr = stderr;
    }
}
