package com.github.loj.utils;

import com.github.loj.pojo.vo.ConfigVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Slf4j(topic = "loj")
public class ConfigUtils {
    
    @Autowired
    private ConfigVO configVO;
    
    public String getConfigContent() {
        return buildYamlStr(configVO);
    }
    
    public String buildYamlStr(ConfigVO configVO) {
        return "loj:\n" +
                "  jwt:\n" +
                "    # 加密秘钥\n" +
                "    secret: " + configVO.getTokenSecret() + "\n" +
                "    # token有效时长，1天，单位秒\n" +
                "    expire: " + configVO.getTokenExpire() + "\n" +
                "    checkRefreshExpire: " + configVO.getCheckRefreshExpire() + "\n" +
                "    header: token\n" +
                "  judge:\n" +
                "    # 调用判题服务器的token\n" +
                "    token: " + configVO.getJudgeToken() + "\n" +
                "  db:\n" +
                "    host: " + configVO.getMysqlHost() + "\n" +
                "    port: " + configVO.getMysqlPort() + "\n" +
                "    public-host: " + configVO.getMysqlPublicHost() + "\n" +
                "    public-port: " + configVO.getMysqlPublichPort() + "\n" +
                "    name: " + configVO.getMysqlDBName() + "\n" +
                "    username: " + configVO.getMysqlUsername() + "\n" +
                "    password: " + configVO.getMysqlPassword() + "\n" +
                "  redis:\n" +
                "    host: " + configVO.getRedisHost() + "\n" +
                "    port: " + configVO.getRedisPort() + "\n" +
                "    password: " + configVO.getRedisPassword();
    }
    
}
