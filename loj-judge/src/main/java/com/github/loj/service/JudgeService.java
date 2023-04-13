package com.github.loj.service;

import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;

public interface JudgeService {

    public TestJudgeRes testJudge(TestJudgeReq testJudgeReq);

}
