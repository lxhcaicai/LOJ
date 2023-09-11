package com.github.loj.pojo.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * @author lxhcaicai
 * @date 2023/4/24 21:14
 */
@ApiModel(value="用户的系统消息", description="")
@Data
public class SysMsgVO {

    private Long id;

    @ApiModelProperty(value = "通知标题")
    private String title;

    @ApiModelProperty(value = "通知内容")
    private String content;

    @ApiModelProperty(value = "发布通知的管理员id")
    private String adminId;

    @ApiModelProperty(value = "消息类型, 系统通知Sys,我的信息Mine")
    private String type;

    @ApiModelProperty(value = "是否已读")
    private Boolean state;

    private Date gmtCreate;
}
