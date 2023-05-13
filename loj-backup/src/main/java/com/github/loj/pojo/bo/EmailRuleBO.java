package com.github.loj.pojo.bo;

import lombok.Data;
import org.springframework.beans.factory.config.YamlPropertiesFactoryBean;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.PropertiesPropertySource;
import org.springframework.core.io.support.DefaultPropertySourceFactory;
import org.springframework.core.io.support.EncodedResource;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

/**
 * 邮箱规则类，读取email-rule.yml文件
 * @author lxhcaicai
 * @date 2023/5/13 22:55
 */
@Component
@PropertySource(value = "classpath:email-rule.yml", factory = CompositePropertySourceFactory.class)
@ConfigurationProperties(prefix = "loj")
@Data
public class EmailRuleBO {
    List<String> blackList;
}

class CompositePropertySourceFactory extends DefaultPropertySourceFactory {
    @Override
    public org.springframework.core.env.PropertySource<?> createPropertySource(@Nullable String name, EncodedResource resource) throws IOException {
        String sourceName = Optional.ofNullable(name).orElse(resource.getResource().getFilename());
        if(!resource.getResource().exists()) {
            // 返回空的 properties
            return new PropertiesPropertySource(sourceName, new Properties());
        } else if(sourceName.endsWith(".yml") || sourceName.endsWith(".yaml")) {
            Properties propertiesFromYaml = loadYaml(resource);
            return new PropertiesPropertySource(sourceName, propertiesFromYaml);
        } else {
            return super.createPropertySource(name, resource);
        }
    }


    /**
     * load yaml file to properties
     * @param resource
     * @return
     */
    private Properties loadYaml(EncodedResource resource) {
        YamlPropertiesFactoryBean factory = new YamlPropertiesFactoryBean();
        factory.setResources(resource.getResource());
        factory.afterPropertiesSet();
        return factory.getObject();
    }
}
