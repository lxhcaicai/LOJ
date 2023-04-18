package com.github.loj.service.impl;

import cn.hutool.core.map.MapUtil;
import cn.hutool.json.JSONUtil;
import com.github.loj.judge.SandboxRun;
import com.github.loj.service.JudgeServerEntityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/4/18 21:39
 */
@Service
@Slf4j(topic = "loj")
public class JudgeServerEntityServiceImpl implements JudgeServerEntityService {

    @Value("${loj-judge-server.max-task-num}")
    private Integer maxTaskNum;

    @Value("${loj-judge-server.remote-judge.open}")
    private Boolean isOpenRemoteJudge;

    @Value("${loj-judge-server.remote-judge.max-task-num}")
    private Integer remoteJudgeMaxTaskNum;

    @Value("${loj-judge-server.name}")
    private String name;

    @Override
    public HashMap<String, Object> getJudgeServerInfo() {
        HashMap<String,Object> result = new HashMap<>();

        result.put("version", "20230418");
        result.put("currentTime", new Date());
        result.put("judgeServerName", name);
        result.put("languages", Arrays.asList("G++ 9.4.0", "GCC 9.4.0", "Python 3.7.5",
                "Python 2.7.17", "OpenJDK 1.8", "Golang 1.19", "C# Mono 4.6.2",
                "PHP 7.3.33","JavaScript Node 14.19.0","JavaScript V8 8.4.109",
                "PyPy 2.7.18 (7.3.8)","PyPy 3.8.12 (7.3.8)"));

        if(maxTaskNum == -1) {
            result.put("maxTaskNum", Runtime.getRuntime().availableProcessors() + 1);
        } else {
            result.put("maxTaskNum", maxTaskNum);
        }

        if(isOpenRemoteJudge) {
            result.put("isOpenRemoteJudge", true);
            if(remoteJudgeMaxTaskNum == -1) {
                result.put("remoteJudgeMaxTaskNum", Runtime.getRuntime().availableProcessors() * 2 + 1);
            } else {
                result.put("remoteJudgeMaxTaskNum", remoteJudgeMaxTaskNum);
            }
        }

        String versionResp = "";

        try {
            versionResp = SandboxRun.getRestTemplate().getForObject(SandboxRun.getSandboxBaseUrl() + "version", String.class);
        } catch (Exception exception) {
            result.put("SandBoxMsg", MapUtil.builder().put("error", exception.getMessage()).map());
            return result;
        }
        result.put("SandBoxMsg", JSONUtil.parse(versionResp));
        return result;
    }
}
