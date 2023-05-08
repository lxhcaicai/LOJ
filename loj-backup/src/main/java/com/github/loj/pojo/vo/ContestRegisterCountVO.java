package com.github.loj.pojo.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/5/8 21:16
 */
@Data
@ApiModel(value="比赛报名统计", description="")
public class ContestRegisterCountVO {

    @ApiModelProperty(value = "比赛id")
    private Long cid;

    @ApiModelProperty(value = "比赛报名人数")
    private Integer count;

}
