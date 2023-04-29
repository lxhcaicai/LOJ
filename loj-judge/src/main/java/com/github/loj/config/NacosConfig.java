package com.github.loj.config;

import com.alibaba.cloud.nacos.NacosDiscoveryProperties;
import com.github.loj.util.IpUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/4/29 20:03
 */
@Configuration
public class NacosConfig {

    private static final int cpuNum = Runtime.getRuntime().availableProcessors();;

    @Value("${loj-judge-server.max-task-num}")
    private Integer maxTaskNum;

    @Value("${loj-judge-server.remote-judge.max-task-num}")
    private Integer maxRemoteTaskNum;

    @Value("${loj-judge-server.remote-judge.open}")
    private Boolean openRemoteJudge;

    @Value("${loj-judge-server.ip}")
    private String ip;

    @Value("${loj-judge-server.port}")
    private Integer port;

    @Value("${loj-judge-server.name}")
    private String name;


    @Bean
    @Primary
    public NacosDiscoveryProperties nacosDiscoveryProperties() {
        NacosDiscoveryProperties nacosDiscoveryProperties = new NacosDiscoveryProperties();
        nacosDiscoveryProperties.setIp(IpUtils.getServiceIp());
        HashMap<String,String> meta = new HashMap<>();

        int max = cpuNum * 2 + 1;
        if(maxTaskNum != -1) {
            max = maxTaskNum;
        }
        meta.put("maxTaskNum", String.valueOf(max));
        if(openRemoteJudge) {
            max = (cpuNum * 2 + 1) * 2;
            if(maxRemoteTaskNum != -1) {
                max = maxRemoteTaskNum;
            }
            meta.put("maxRemoteTaskNum", String.valueOf(max));
        }
        meta.put("judgeNum", name);
        nacosDiscoveryProperties.setMetadata(meta);
        if(!ip.equals("-1")) {
            nacosDiscoveryProperties.setIp(ip);
        }
        nacosDiscoveryProperties.setPort(port);

        nacosDiscoveryProperties.setService("loj-judge-server");
        return nacosDiscoveryProperties;
    }

}
