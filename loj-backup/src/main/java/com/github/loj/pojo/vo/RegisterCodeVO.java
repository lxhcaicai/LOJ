package com.github.loj.pojo.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @author lxhcaicai
 * @date 2023/5/13 22:29
 */
@Data
@Accessors(chain = true)
public class RegisterCodeVO {

    @ApiModelProperty(value = "邮箱")
    private String email;

    @ApiModelProperty(value = "注册邮件有效时间，单位秒")
    private Integer expire;

}
