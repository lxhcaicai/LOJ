package com.github.loj.pojo.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/5/5 20:51
 */
@ApiModel(value="OI排行榜数据类OIRankVO", description="")
@Data
public class OIRankVO {

    @ApiModelProperty(value = "用户id")
    private String uid;

    @ApiModelProperty(value = "用户名")
    private String username;

    @ApiModelProperty(value = "昵称")
    private String nickname;

    @ApiModelProperty(value = "头像地址")
    private String avatar;

    @ApiModelProperty(value = "头衔、称号")
    private String titleName;

    @ApiModelProperty(value = "头衔、称号的颜色")
    private String titleColor;

    @ApiModelProperty(value = "OI得分列表")
    private Integer score;

    @ApiModelProperty(value = "总提交数")
    private Integer total;

    @ApiModelProperty(value = "总通过数")
    private Integer ac;
}
