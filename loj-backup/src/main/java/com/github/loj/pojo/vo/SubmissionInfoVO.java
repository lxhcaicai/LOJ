package com.github.loj.pojo.vo;

import com.github.loj.pojo.entity.judge.Judge;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/5/8 20:40
 */
@Data
public class SubmissionInfoVO {

    @ApiModelProperty(value = "提交详情")
    private Judge submission;

    @ApiModelProperty(value = "提交者是否可以分享该代码")
    private Boolean codeShare;
}
