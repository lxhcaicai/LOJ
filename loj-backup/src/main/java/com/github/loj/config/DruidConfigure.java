package com.github.loj.config;

import com.alibaba.druid.pool.DruidDataSource;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Optional;

/**
 * @author lxhcaicai
 * @date 2023/4/26 22:50
 */
@Configuration
@Slf4j(topic = "loj")
@RefreshScope
@Data
public class DruidConfigure {
    @Value("${mysql-username}")
    private String username;

    @Value("${mysql-password}")
    private String password;

    @Value("${mysql-host}")
    private String host;

    @Value("${mysql-port}")
    private Integer port;

    @Value("${mysql-name}")
    private String name;

    @Value("${spring.datasource.driver-class-name}")
    private String driverClassName;

    @Value("${spring.datasource.type}")
    private String type;

    @Value("${spring.datasource.initial-size:10}")
    private Integer initialSize;

    @Value("${spring.datasource.poolPreparedStatements:true}")
    private Boolean poolPreparedStatements;

    @Value("${spring.datasource.maxPoolPreparedStatementPerConnectionSize:20}")
    private Integer maxPoolPreparedStatementPerConnectionSize;

    @Value("${spring.datasource.timeBetweenEvictionRunsMillis:60000}")
    private Integer timeBetweenEvictionRunsMillis;

    @Value("${spring.datasource.minEvictableIdleTimeMillis:300000}")
    private Integer minEvictableIdleTimeMillis;

    @Value("${spring.datasource.validationQuery}")
    private String validationQuery;

    @Value("${spring.datasource.testWhileIdle:true}")
    private Boolean testWhileIdle;

    @Value("${spring.datasource.testOnBorrow:false}")
    private Boolean testOnBorrow;

    @Value("${spring.datasource.testOnReturn:false}")
    private Boolean testOnReturn;

    @Value("${spring.datasource.connectionErrorRetryAttempts:3}")
    private Integer connectionErrorRetryAttempts;

    @Value("${spring.datasource.breakAfterAcquireFailure:true}")
    private Boolean breakAfterAcquireFailure;

    @Value("${spring.datasource.timeBetweenConnectErrorMillis:300000}")
    private Integer timeBetweenConnectErrorMillis;

    @Value("${spring.datasource.min-idle:20}")
    private Integer minIdle;

    @Value("${spring.datasource.maxActive:200}")
    private Integer maxActive;

    @Value("${spring.datasource.maxWait:60000}")
    private Integer maxWait;

    @Autowired
    private DataSourceConfigure dataSourceConfigure;

    @Bean(name = "datasource")
    @RefreshScope
    public DruidDataSource dataSource() {
        String mysqlHost = Optional.ofNullable(dataSourceConfigure.getHost()).orElseGet(() -> host);
        Integer mysqlPort = Optional.ofNullable(dataSourceConfigure.getPort()).orElseGet(()->port);
        String mysqlName = Optional.ofNullable(dataSourceConfigure.getName()).orElseGet(() -> name);
        String mysqlUsername = Optional.of(dataSourceConfigure.getUsername()).orElseGet(() -> username);
        String mysqlUserPassword = Optional.ofNullable(dataSourceConfigure.getPassword()).orElseGet(()-> password);

        log.warn("[MySQL] [Config Init] name:[{}], host:[{}], port:[{}], username:[{}], password:[{}]",
                mysqlName, mysqlHost, mysqlPort, mysqlUsername, mysqlUserPassword);

        DruidDataSource dataSource = new DruidDataSource();
        String url = "jdbc:mysql://" + mysqlHost + ":" + mysqlPort + "/" + mysqlName + "?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai&allowMultiQueries=true&rewriteBatchedStatements=true";

        dataSource.setUrl(url);
        dataSource.setUsername(mysqlUsername);
        dataSource.setPassword(mysqlUserPassword);
        dataSource.setDriverClassName(driverClassName);
        dataSource.setDbType(type);
        dataSource.setMaxActive(maxActive);
        dataSource.setInitialSize(initialSize);
        dataSource.setMinIdle(minIdle);
        dataSource.setMaxWait(maxWait);
        dataSource.setPoolPreparedStatements(poolPreparedStatements);
        dataSource.setMaxPoolPreparedStatementPerConnectionSize(maxPoolPreparedStatementPerConnectionSize);
        dataSource.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMillis);
        dataSource.setMinEvictableIdleTimeMillis(minEvictableIdleTimeMillis);
        dataSource.setValidationQuery(validationQuery);
        dataSource.setTestWhileIdle(testWhileIdle);
        dataSource.setTestOnReturn(testOnReturn);
        dataSource.setTestOnBorrow(testOnBorrow);
        dataSource.setConnectionErrorRetryAttempts(connectionErrorRetryAttempts);
        dataSource.setBreakAfterAcquireFailure(breakAfterAcquireFailure);
        dataSource.setTimeBetweenConnectErrorMillis(timeBetweenConnectErrorMillis);

        return dataSource;
    }
}
