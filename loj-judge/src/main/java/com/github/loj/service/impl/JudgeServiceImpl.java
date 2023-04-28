package com.github.loj.service.impl;

import com.github.loj.common.exception.SystemError;
import com.github.loj.judge.JudgeContext;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import com.github.loj.service.JudgeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/4/14 0:40
 */
@Service
public class JudgeServiceImpl implements JudgeService {

    @Resource
    private JudgeContext judgeContext;

    @Override
    public TestJudgeRes testJudge(TestJudgeReq testJudgeReq) {
        return judgeContext.testJudgeRes(testJudgeReq);
    }

    @Override
    public Boolean compileSpj(String code, Long pid, String spjLanguage, HashMap<String, String> extraFiles) throws SystemError {
        return judgeContext.compileSpj(code, pid, spjLanguage, extraFiles);
    }
}
