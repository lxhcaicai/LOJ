package com.github.loj.config;

import com.github.loj.utils.IpUtils;
import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/4/27 1:51
 */
@Data
public class WebConfig {

    private String emailUsername;

    private String emailPassword;

    private String emailHost;

    private Boolean emailSsl = true;

    private String emailBGImg = "https://cdn.jsdelivr.net/gh/HimitZH/CDN/images/HCODE.png";

    // 网站前端显示配置
    private String baseUrl = "http://" + IpUtils.getServiceIp();

    private String name = "Online Judge";

    private String shortName = "LOJ";

    private String description;

    private Boolean register = true;

    private String recordName;

    private String recordUrl;

    private String projectName = "LOJ";

    private String projectUrl = "https://github.com/lxhcaicai/loj";
}
