package com.github.loj.pojo.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/5/5 20:48
 */
@Data
@Builder
public class UserHomeProblemVO {

    @ApiModelProperty(value = "主键id")
    private Long id;

    @ApiModelProperty(value = "题目的自定义ID 例如（HOJ-1000）")
    private String problemId;

    @ApiModelProperty(value = "题目难度")
    private Integer difficulty;
}
