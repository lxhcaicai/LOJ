package com.github.loj.pojo.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * @author lxhcaicai
 * @date 2023/5/6 20:00
 */
@Data
public class AdminEditUserDTO {

    @NotBlank(message = "username不能为空")
    private String username;

    @NotBlank(message = "uid不能为空")
    private String uid;

    private String realname;

    private String email;

    private String password;

    private Integer type;

    private Integer status;

    private Boolean setNewPwd;

    private String titleName;

    private String titleColor;
}
