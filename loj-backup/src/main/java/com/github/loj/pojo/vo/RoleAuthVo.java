package com.github.loj.pojo.vo;

import com.github.loj.pojo.entity.user.Auth;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/23 0:01
 */
@ApiModel(value="角色以及其对应的权限列表", description="")
@Data
public class RoleAuthVo {

    @ApiModelProperty(value = "角色id")
    private Long id;

    @ApiModelProperty(value = "角色")
    private String role;

    @ApiModelProperty(value = "描述")
    private String description;

    @ApiModelProperty(value = "默认0可以用, 1 不可用")
    private Integer status;

    @ApiModelProperty(value = "创建时间")
    private Date gmtCreate;

    @ApiModelProperty(value = "修改时间")
    private Date gmtModified;

    @ApiModelProperty(value = "权限列表")
    private List<Auth> auths;
}
