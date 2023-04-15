package com.github.loj.service.impl;

import com.github.loj.judge.JudgeContext;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import com.github.loj.service.JudgeService;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/4/14 0:40
 */
public class JudgeServiceImpl implements JudgeService {

    @Resource
    private JudgeContext judgeContext;

    @Override
    public TestJudgeRes testJudge(TestJudgeReq testJudgeReq) {
        return judgeContext.testJudgeRes(testJudgeReq);
    }
}
