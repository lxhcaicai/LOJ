package com.github.loj.config;

import com.baomidou.mybatisplus.extension.plugins.OptimisticLockerInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * @author lxhcaicai
 * @date 2023/4/28 23:48
 */
@Configuration
@EnableTransactionManagement
@MapperScan("com.github.loj.mapper")
public class MybatisPlusConfig {

    // 注册乐观
    @Bean
    public OptimisticLockerInterceptor optimisticLockerInterceptor() {
        return new OptimisticLockerInterceptor();
    }

}
