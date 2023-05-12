package com.github.loj.pojo.dto;

import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/5/13 0:22
 */
@Data
public class ApplyResetPasswordDTO {

    private String captcha;

    private String captchaKey;

    private String email;

}
