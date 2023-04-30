package com.github.loj.judge;

import com.github.loj.common.exception.SystemError;
import com.github.loj.dao.ContestRecordEntityService;
import com.github.loj.dao.UserAcproblemEntityService;
import com.github.loj.judge.entity.LanguageConfig;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import com.github.loj.pojo.user.UserAcproblem;
import com.github.loj.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/4/14 0:44
 */
@Component
public class JudgeContext {

    @Autowired
    private JudgeStrategy judgeStrategy;

    @Autowired
    private UserAcproblemEntityService userAcproblemEntityService;

    @Resource
    private LanguageConfigLoader languageConfigLoader;

    @Resource
    private ContestRecordEntityService contestRecordEntityService;

    public TestJudgeRes testJudgeRes(TestJudgeReq testJudgeReq) {
        // c和c++为一倍时间和空间，其它语言为2倍时间和空间
        LanguageConfig languageConfig = languageConfigLoader.getLanguageConfigByName(testJudgeReq.getLanguage());
        if(languageConfig.getSrcName() == null
                || (!languageConfig.getSrcName().endsWith(".c")
                && !languageConfig.getSrcName().endsWith(".cpp"))) {
            testJudgeReq.setTimeLimit(testJudgeReq.getTimeLimit() * 2);
            testJudgeReq.setMemoryLimit(testJudgeReq.getMemoryLimit() * 2);
        }
        return  judgeStrategy.testJudge(testJudgeReq);
    }

    public Boolean compileSpj(String code, Long pid, String sojLanguage, HashMap<String,String> extraFiles) throws SystemError {
        return Compiler.compileSpj(code, pid, sojLanguage, extraFiles);
    }

    public Boolean compileInteractive(String code, Long pid, String interactiveLanguage, HashMap<String, String> extraFiles) throws SystemError{
        return Compiler.compileInteractive(code, pid, interactiveLanguage, extraFiles);
    }

    public void updateOtherTable(Long submitId,
                                 Integer status,
                                 Long cid,
                                 String uid,
                                 Long pid,
                                 Long gid,
                                 Integer score,
                                 Integer userTime) {
        if(cid == 0) {
            // 非比赛提交
            // 如果是AC,就更新user_acproblem表,

            if(status.intValue() == Constants.Judge.STATUS_ACCEPTED.getStatus() && gid == null) {
                userAcproblemEntityService.saveOrUpdate(new UserAcproblem()
                        .setPid(pid)
                        .setUid(uid)
                        .setSubmitId(submitId));
            }
        } else { // 如果时比赛提交
            contestRecordEntityService.updateContestRecord(score, status, submitId, userTime);
        }
    }
}
