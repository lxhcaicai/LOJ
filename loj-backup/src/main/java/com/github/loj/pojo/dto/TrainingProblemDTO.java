package com.github.loj.pojo.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class TrainingProblemDTO {

    @NotBlank(message = "题目id不能为空")
    private Long pid;

    @NotBlank(message = "训练id不能为空")
    private Long tid;

    @NotBlank(message = "题目在训练中的展示id不能为空")
    private String displayId;
}
