package com.github.loj.pojo.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class ContestProblemDTO {

    @NotBlank(message = "题目id不能为空")
    private Long pid;

    @NotBlank(message = "比赛id不能为空")
    private Long cid;

    @NotBlank(message = "题目在比赛中的展示id不能为空")
    private String displayId;
}
