package com.github.loj.pojo.vo;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

@RefreshScope
@Data
@Component
public class ConfigVO {
    // 数据库配置
    @Value("${loj.db.username}")
    private String mysqlUsername;

    @Value("${loj.db.password}")
    private String mysqlPassword;

    @Value("${loj.db.name}")
    private String mysqlDBName;

    @Value("${loj.db.host}")
    private String mysqlHost;

    @Value("${loj.db.public-host:172.20.0.3}")
    private String mysqlPublicHost;

    @Value("${loj.db.port}")
    private Integer mysqlPort;

    @Value("${loj.db.public-port:3306}")
    private Integer mysqlPublishPort;

    @Value("${loj.judge.token}")
    private String judgeToken;

    @Value("${loj.redis.host}")
    private String redisHost;

    @Value("${loj.redis.port}")
    private String redisPort;

    @Value("${loj.redis.password}")
    private String redisPassword;

    // jwt配置
    @Value("${loj.jwt.secret}")
    private String tokenSecret;

    @Value("${loj.jwt.expire}")
    private String tokenExpire;

    @Value("${loj.jwt.checkRefreshExpire}")
    private String checkRefreshExpire;

}
