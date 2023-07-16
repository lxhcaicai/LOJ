package com.github.loj.pojo.dto;

import lombok.Data;

@Data
public class ChangeEmailDTO {
    private String password;

    private String newEmail;

    private String code;
}
