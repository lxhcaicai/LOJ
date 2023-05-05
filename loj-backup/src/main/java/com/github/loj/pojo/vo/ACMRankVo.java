package com.github.loj.pojo.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * @author lxhcaicai
 * @date 2023/5/5 20:38
 */
@ApiModel(value="ACM排行榜数据类ACMRankVO", description="")
@Data
public class ACMRankVo implements Serializable {

    @ApiModelProperty(value = "用户id")
    private String uid;

    @ApiModelProperty(value = "用户名")
    private String username;

    @ApiModelProperty(value = "昵称")
    private String nickname;

    @ApiModelProperty(value = "个性签名")
    private String signature;

    @ApiModelProperty(value = "头像地址")
    private String avatar;

    @ApiModelProperty(value = "头衔、称号")
    private String titleName;

    @ApiModelProperty(value = "头衔、称号的颜色")
    private String titleColor;

    @ApiModelProperty(value = "总提交数")
    private Integer total;

    @ApiModelProperty(value = "总通过数")
    private Integer ac;

    @ApiModelProperty(value = "cf得分")
    private Integer rating;
}
