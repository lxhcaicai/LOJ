package com.github.loj.config;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.loj.dao.JudgeServerEntityService;
import com.github.loj.pojo.judge.JudgeServer;
import com.github.loj.util.IpUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/4/29 21:55
 */
@Component
@Slf4j
public class StartupRunner implements CommandLineRunner {

    @Value("${loj-judge-server.max-task-num}")
    private Integer maxTaskNum;

    @Value("${loj-judge-server.remote-judge.max-task-num}")
    private Integer maxRemoteTaskNum;

    @Value("${loj-judge-server.remote-judge.open}")
    private Boolean openRemoteJudge;

    @Value("${loj-judge-server.name}")
    private String name;

    @Value("${loj-judge-server.ip}")
    private String ip;

    @Value("${loj-judge-server.port}")
    private Integer port;

    private static final int cpuNum = Runtime.getRuntime().availableProcessors();

    @Autowired
    private JudgeServerEntityService judgeServerEntityService;

    @Override
    public void run(String... args) throws Exception {
        log.info("IP  of the current judge server:" + ip);
        log.info("Port of the current judge server:" + port);

        if(maxTaskNum == -1) {
            maxTaskNum = cpuNum + 1;
        }

        if(ip.equals("-1")) {
            ip = IpUtils.getLocalIpv4Address();
        }
        UpdateWrapper<JudgeServer> judgeServerQueryWrapper = new UpdateWrapper<>();
        judgeServerQueryWrapper.eq("ip", ip).eq("port", port);
        judgeServerEntityService.remove(judgeServerQueryWrapper);
        boolean isOk1 = judgeServerEntityService.save(new JudgeServer()
                .setCpuCore(cpuNum)
                .setIp(ip)
                .setPort(port)
                .setUrl(ip+":"+port)
                .setMaxTaskNumber(maxTaskNum)
                .setIsRemote(false)
                .setName(name));

        boolean isOk2 = true;
        if(openRemoteJudge) {
            if(maxRemoteTaskNum == -1) {
                maxRemoteTaskNum = cpuNum * 2 + 1;
            }
            isOk2 = judgeServerEntityService.save(new JudgeServer()
                    .setCpuCore(cpuNum)
                    .setIp(ip)
                    .setPort(port)
                    .setUrl(ip+":"+ port)
                    .setMaxTaskNumber(maxRemoteTaskNum)
                    .setIsRemote(true)
                    .setName(name));
        }

        if(!isOk1 || !isOk2) {
            log.error("初始化判题机信息到数据库失败，请重新启动试试！");
        } else {
            HashMap<String, Object> judgeServerInfo = judgeServerEntityService.getJudgeServerInfo();
            log.info("LOJ-JudgeServer had successfully started! The judge config and sandbox config Info:" + judgeServerInfo);
        }

    }
}
