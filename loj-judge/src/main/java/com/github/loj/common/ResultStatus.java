package com.github.loj.common;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author lxhcaicai
 * @date 2023/4/13 1:39
 */
@Getter
@AllArgsConstructor
public enum ResultStatus {

    SUCCESS(200,"成功"),

    FAIL(400,"失败"),

    ACCESS_DENIED(401, "访问受限"),

    FORBIDDEN(403,"拒绝访问"),

    NOT_FOUND(404,"数据不存在"),

    SYSTEM_ERROR(500,"系统错误");

    private int status;

    private String description;
}
