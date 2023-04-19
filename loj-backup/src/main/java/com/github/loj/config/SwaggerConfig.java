package com.github.loj.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.env.Environment;
import org.springframework.core.env.Profiles;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.ArrayList;

/**
 * @author lxhcaicai
 * @date 2023/4/20 0:36
 */
@Configuration
@EnableSwagger2 // 开启swagger2
@Profile({"sit","test"}) // 只允许开发sit环境访问
public class SwaggerConfig {
    @Bean //配置swagger的docket的bean实例
    public Docket docket(Environment environment) {
        //设置要显示的swagger环
        Profiles profiles = Profiles.of("sit","test");
        //通过环境判断是否在自己所设定的环境当中
        boolean flag = environment.acceptsProfiles(profiles);
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .groupName("loJ")
                .enable(flag)
                .select()
                //RequestHandlerSelectors扫描方式
                //any()全部
                //none 都不扫描
                //path 过滤什么路径
                .apis(RequestHandlerSelectors.basePackage("com.github"))
                .build();
    }

    private ApiInfo apiInfo() {
        Contact contact = new Contact("lxhcaicai","", "2778763221@qq.com");
        return new ApiInfo(
                "LOJ-JudgeServer API文档",
                "JUDGE 判题服务接口文档",
                "v1.0",
                "",
                contact,
                "MIT",
                "http://www.apache.org/licenses/LICENSE-2.0",
                new ArrayList<>());
    }
}
