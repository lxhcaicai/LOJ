package com.github.loj.pojo.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * @author lxhcaicai
 * @date 2023/4/24 20:46
 */
@Data
@ApiModel(value = "系统通知消息", description = "")
public class AdminSysNoticeVO {
    private Long id;

    @ApiModelProperty(value = "通知标题")
    private String title;

    @ApiModelProperty(value = "通知内容")
    private String content;

    @ApiModelProperty(value = "发给哪些用户类型,例如全部用户All，指定单个用户Single，管理员Admin")
    private String type;

    @ApiModelProperty(value = "是否已被拉取过，如果已经拉取过，就无需再次拉取")
    private Boolean state;

    @ApiModelProperty(value = "发布通知的管理员用户名")
    private String adminUsername;

    private Date gmtCreate;

    private Date gmtModified;
}
