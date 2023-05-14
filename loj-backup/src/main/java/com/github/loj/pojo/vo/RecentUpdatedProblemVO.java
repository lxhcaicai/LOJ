package com.github.loj.pojo.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;

import java.util.Date;

/**
 * @author lxhcaicai
 * @date 2023/5/15 0:43
 */
@Data
@Builder
public class RecentUpdatedProblemVO {

    @ApiModelProperty(value = "主键id")
    private Long id;

    @ApiModelProperty(value = "题目的自定义ID 例如（HOJ-1000）")
    private String problemId;

    @ApiModelProperty(value = "题目")
    private String title;

    @ApiModelProperty(value = "0为ACM,1为OI")
    private Integer type;

    @ApiModelProperty(value = "创建时间")
    private Date gmtCreate;

    @ApiModelProperty(value = "最近更新时间")
    private Date gmtModified;
}
