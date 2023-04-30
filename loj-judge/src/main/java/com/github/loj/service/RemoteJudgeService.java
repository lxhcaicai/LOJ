package com.github.loj.service;

/**
 * @author lxhcaicai
 * @date 2023/4/30 9:28
 */
public interface RemoteJudgeService {

    public void changeAccountStatus(String remoteJudge, String username);

    public void changeServerSubmitCFStatus(String ip, Integer port);

}
