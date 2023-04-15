package com.github.loj.judge;

import com.github.loj.judge.entity.LanguageConfig;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/4/14 0:44
 */
@Component
public class JudgeContext {

    @Autowired
    private JudgeStrategy judgeStrategy;

    @Resource
    private LanguageConfigLoader languageConfigLoader;

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
}
