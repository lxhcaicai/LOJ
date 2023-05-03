package com.github.loj.service;

import com.github.loj.common.exception.SystemError;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import com.github.loj.pojo.dto.ToJudgeDTO;
import com.github.loj.pojo.entity.judge.Judge;

import java.util.HashMap;

public interface JudgeService {

    public TestJudgeRes testJudge(TestJudgeReq testJudgeReq);

    public Boolean compileSpj(String code, Long pid, String spjLanguage, HashMap<String,String> extraFiles) throws SystemError;

    public Boolean compileInteractive(String code, Long pid, String interactiveLanguage, HashMap<String,String> extraFiles) throws SystemError;

    public void remoteJudge(ToJudgeDTO toJudgeDTO);

    public void judge(Judge judge);
}
