package com.github.loj.pojo.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @author lxhcaicai
 * @date 2023/4/24 1:59
 * 登录数据实体类
 */
@Data
public class LoginDTO implements Serializable {
    @NotBlank(message = "用户名不能为空")
    private String username;

    @NotBlank(message = "密码不能为空")
    private String password;
}
