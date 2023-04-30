package com.github.loj.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.loj.common.exception.SystemError;
import com.github.loj.dao.JudgeEntityService;
import com.github.loj.dao.JudgeServerEntityService;
import com.github.loj.judge.JudgeContext;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import com.github.loj.pojo.dto.ToJudgeDTO;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.remoteJudge.RemoteJudgeContext;
import com.github.loj.service.JudgeService;
import com.github.loj.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/4/14 0:40
 */
@Service
public class JudgeServiceImpl implements JudgeService {

    @Value("${loj-judge-server.name}")
    private String name;

    @Resource
    JudgeEntityService judgeEntityService;

    @Resource
    private JudgeContext judgeContext;

    @Autowired
    private RemoteJudgeContext remoteJudgeContext;

    @Override
    public TestJudgeRes testJudge(TestJudgeReq testJudgeReq) {
        return judgeContext.testJudgeRes(testJudgeReq);
    }

    @Override
    public Boolean compileSpj(String code, Long pid, String spjLanguage, HashMap<String, String> extraFiles) throws SystemError {
        return judgeContext.compileSpj(code, pid, spjLanguage, extraFiles);
    }

    @Override
    public Boolean compileInteractive(String code, Long pid, String interactiveLanguage, HashMap<String, String> extraFiles) throws SystemError {
        return judgeContext.compileInteractive(code, pid, interactiveLanguage, extraFiles);
    }

    @Override
    public void remoteJudge(ToJudgeDTO toJudgeDTO) {
        Judge judge = toJudgeDTO.getJudge();
        UpdateWrapper<Judge> judgeUpdateWrapper = new UpdateWrapper<>();
        judgeUpdateWrapper.set("status", Constants.Judge.STATUS_PENDING.getStatus())
                .set("judger", name)
                .eq("submit_id",judge.getSubmitId())
                .ne("status", Constants.Judge.STATUS_CANCELLED.getStatus());

        boolean isUpdateOk = judgeEntityService.update(judgeUpdateWrapper);

        // 没更新成功，则可能表示该评测被取消 或者 judge记录被删除了，则结束评测
        if(!isUpdateOk) {
            judgeContext.updateOtherTable(judge.getSubmitId(),
                    Constants.Judge.STATUS_CANCELLED.getStatus(),
                    judge.getCid(),
                    judge.getUid(),
                    judge.getPid(),
                    judge.getGid(),
                    null,
                    null);
            return;
        }
        remoteJudgeContext.judge(toJudgeDTO);

    }
}
