package com.github.loj.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.loj.dao.JudgeServerEntityService;
import com.github.loj.dao.RemoteJudgeAccountEntityService;
import com.github.loj.pojo.entity.judge.RemoteJudgeAccount;
import com.github.loj.pojo.judge.JudgeServer;
import com.github.loj.service.RemoteJudgeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
 * @author lxhcaicai
 * @date 2023/4/30 9:32
 */
@Service
@Slf4j(topic = "loj")
public class RemoteJudgeServiceImpl implements RemoteJudgeService {

    @Autowired
    private RemoteJudgeAccountEntityService remoteJudgeAccountEntityService;

    @Autowired
    private JudgeServerEntityService judgeServerEntityService;

    @Override
    public void changeAccountStatus(String remoteJudge, String username) {
        UpdateWrapper<RemoteJudgeAccount> remoteJudgeAccountUpdateWrapper = new UpdateWrapper<>();
        remoteJudgeAccountUpdateWrapper.set("status", true)
                .eq("username", username);

        if(remoteJudge.equals("GYM")) {
            remoteJudge = "CF";
        }
        remoteJudgeAccountUpdateWrapper.eq("oj", remoteJudge);

        boolean isOk = remoteJudgeAccountEntityService.update(remoteJudgeAccountUpdateWrapper);

        if(!isOk) {
            tryAgainUpdateAccount(remoteJudgeAccountUpdateWrapper, remoteJudge, username);
        }
    }

    private void tryAgainUpdateAccount(UpdateWrapper<RemoteJudgeAccount> updateWrapper, String remoteJudge, String username) {
        boolean retryable;
        int attemptNumber = 0;
        do {
            boolean success = remoteJudgeAccountEntityService.update(updateWrapper);
            if(success) {
                return;
            } else {
                attemptNumber ++;
                retryable = attemptNumber < 8;
                if(attemptNumber == 8) {
                    log.error("Remote Judge：Change Account status to `true` Failed ----------->{}", "oj:" + remoteJudge + ",username:" + username);
                    break;
                }
                try {
                    Thread.sleep(300);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        } while (retryable);
    }

    @Override
    public void changeServerSubmitCFStatus(String ip, Integer port) {
        if(StringUtils.isEmpty(ip) ||port == null)  {
            return;
        }
        UpdateWrapper<JudgeServer> judgeServerUpdateWrapper = new UpdateWrapper<>();
        judgeServerUpdateWrapper.set("cf_submittable", true)
                .eq("ip", ip)
                .eq("is_remote", true)
                .eq("port", port);
        boolean isOk = judgeServerEntityService.update(judgeServerUpdateWrapper);

        if(!isOk) {
            tryAgainUpdateServer(judgeServerUpdateWrapper, ip, port);
        }
    }

    private void tryAgainUpdateServer(UpdateWrapper<JudgeServer> updateWrapper, String ip, Integer port) {
        boolean retryable;
        int attemptNumber = 0;

        do {
            boolean success =judgeServerEntityService.update(updateWrapper);
            if(success) {
                return;
            } else {
                attemptNumber ++;
                retryable = attemptNumber < 8;
                if(attemptNumber == 8) {
                    log.error("Remote Judge：Change CF Judge Server Status to `true` Failed! =======>{}", "ip:" + ip + ",port:" + port);
                    break;
                }
                try {
                    Thread.sleep(300);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        } while (retryable);
    }
}
