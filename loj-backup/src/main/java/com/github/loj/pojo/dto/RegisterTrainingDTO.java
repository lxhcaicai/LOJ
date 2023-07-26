package com.github.loj.pojo.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class RegisterTrainingDTO {

    @NotBlank(message = "tid不能为空")
    private Long tid;

    @NotBlank(message = "password不能为空")
    private String password;
}
