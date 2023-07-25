package com.github.loj.pojo.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class RandomProblemVO {
    @ApiModelProperty(value = "题目id")
    private String problemId;
}
