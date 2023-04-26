package com.github.loj.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

/**
 * @author lxhcaicai
 * @date 2023/4/26 22:46
 */
@Component
@RefreshScope
@ConfigurationProperties(prefix = "loj.db")
@Data
public class DataSourceConfigure {

    private String username;

    private String password;

    private String host;

    private Integer port;

    private String name;
}
