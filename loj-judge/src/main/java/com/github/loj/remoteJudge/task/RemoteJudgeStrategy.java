package com.github.loj.remoteJudge.task;

/**
 * @author lxhcaicai
 * @date 2023/4/30 10:14
 */

import com.github.loj.remoteJudge.entity.RemoteJudgeDTO;
import com.github.loj.remoteJudge.entity.RemoteJudgeRes;
import lombok.Getter;
import lombok.Setter;

/**
 *  远程评测抽象类
 */
public abstract class RemoteJudgeStrategy {

    @Setter
    @Getter
    private RemoteJudgeDTO remoteJudgeDTO;

    public abstract void submit();

    public abstract RemoteJudgeRes result();

    public abstract void login();

    public abstract String getLanguage(String language);

}
