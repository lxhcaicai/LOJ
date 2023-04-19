package com.github.loj.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

/**
 * @author lxhcaicai
 * @date 2023/4/20 0:54
 */
@Component
@RefreshScope
@ConfigurationProperties(prefix = "loj.redis")
@Data
public class JedisPoolConfigure {
    private String host;

    private Integer port;

    private String password;
}
