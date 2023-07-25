package com.github.loj.pojo.vo;

import lombok.Data;

@Data
public class LastAcceptedCodeVO {
    private Long submitId;

    private String code;

    private String language;
}
