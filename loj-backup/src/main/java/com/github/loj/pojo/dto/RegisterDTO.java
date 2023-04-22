package com.github.loj.pojo.dto;

import lombok.Data;
import lombok.experimental.Accessors;
import org.springframework.lang.Nullable;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @author lxhcaicai
 * @date 2023/4/22 18:45
 *
 */
@Data
@Accessors(chain = true)
public class RegisterDTO implements Serializable {

    @Nullable
    private String uuid;

    @NotBlank(message = "用户名不能为空")
    private String username;

    @NotBlank(message = "密码不能为空")
    private String password;

    @NotBlank(message = "邮箱不能为空")
    @Email(message = "邮箱格式错误")
    private String email;

    @NotBlank(message = "验证码不能为空")
    private String code;
}
