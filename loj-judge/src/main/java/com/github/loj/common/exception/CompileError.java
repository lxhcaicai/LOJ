package com.github.loj.common.exception;

import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/4/14 0:19
 */
@Data
public class CompileError extends Exception{
    private String message;
    private String stdout;
    private String stderr;

    public CompileError(String message, String stdout, String stderr) {
        super(message);
        this.message = message;
        this.stdout = stdout;
        this.stderr = stderr;
    }
}
