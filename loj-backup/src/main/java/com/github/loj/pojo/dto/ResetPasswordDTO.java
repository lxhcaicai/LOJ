package com.github.loj.pojo.dto;

import lombok.Data;

@Data
public class ResetPasswordDTO {

    private String username;

    private String password;

    private String code;
}
