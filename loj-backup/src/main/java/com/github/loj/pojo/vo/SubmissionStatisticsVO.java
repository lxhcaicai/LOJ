package com.github.loj.pojo.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/15 20:17
 */
@Data
public class SubmissionStatisticsVO {

    @ApiModelProperty(value = "最近七天日期格式 mm-dd,升序")
    private List<String> dataStrList;

    @ApiModelProperty(value = "最近七天每天AC数量")
    private List<Long> acCountList;

    @ApiModelProperty(value = "最近七天每天提交数量")
    private List<Long> totalCountList;
}
