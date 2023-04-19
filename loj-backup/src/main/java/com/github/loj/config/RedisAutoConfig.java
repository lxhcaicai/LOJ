package com.github.loj.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.RedisPassword;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import redis.clients.jedis.JedisPoolConfig;

import java.util.Optional;

/**
 * @author lxhcaicai
 * @date 2023/4/20 0:58
 */
@Configuration
public class RedisAutoConfig {

    @Value("${spring.redis.jedis.pool.max-active:200}")
    private Integer maxActive;
    @Value("${spring.redis.jedis.pool.max-idle:50}")
    private Integer maxIdle;
    @Value("${spring.redis.jedis.pool.max-wait:-1}")
    private long maxWait;
    @Value("${spring.redis.jedis.pool.min-idle:10}")
    private Integer minIdle;

    @Value("${redis-host}")
    private String redisHost;
    @Value("${redis-port}")
    private String redisPort;
    @Value("${redis-password}")
    private String redisPassword;

    @Autowired
    private JedisPoolConfigure jedisPoolConfigure;

    @Bean
    public RedisConnectionFactory redisConnectionFactory(JedisPoolConfig jedisPool, RedisStandaloneConfiguration jedisConfig) {
        JedisConnectionFactory connectionFactory = new JedisConnectionFactory(jedisConfig);
        connectionFactory.setPoolConfig(jedisPool);
        return connectionFactory;
    }

    @Bean
    public JedisPoolConfig jedisPoolConfig() {
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        jedisPoolConfig.setMaxIdle(maxIdle);
        jedisPoolConfig.setMaxWaitMillis(maxWait);
        jedisPoolConfig.setMaxTotal(maxActive);
        jedisPoolConfig.setMinIdle(minIdle);
        return jedisPoolConfig;
    }

    @Bean
    @RefreshScope
    public RedisStandaloneConfiguration jedisConfig() {
        RedisStandaloneConfiguration config = new RedisStandaloneConfiguration();
        config.setHostName(Optional.ofNullable(jedisPoolConfigure.getHost()).orElseGet(() -> redisHost));
        config.setPort(Optional.ofNullable(jedisPoolConfigure.getPort()).orElseGet(() -> Integer.valueOf(redisPort)));
        config.setPassword(RedisPassword.of(Optional.ofNullable(jedisPoolConfigure.getPassword()).orElseGet(() -> redisPassword)));

        return config;
    }
}
