package com.github.loj.controller;

import com.github.loj.common.CommonResult;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author lxhcaicai
 * @date 2023/4/13 1:19
 */
@RestController
public class JudgeController {

    @PostMapping(value = "/test-judge")
    public CommonResult<TestJudgeRes> submitProblemTestJudge(@RequestBody TestJudgeReq testJudgeReq) {

        if(testJudgeReq == null
                || StringUtils.isEmpty(testJudgeReq.getCode())
                || StringUtils.isEmpty(testJudgeReq.getLanguage())
                || StringUtils.isEmpty(testJudgeReq.getUniqueKey())
                || testJudgeReq.getTimeLimit() == null
                || testJudgeReq.getMemoryLimit() == null
                || testJudgeReq.getStackLimit() == null) {
            return CommonResult.errorResponse("调用参数错误!请检查你的调用参数!");
        }
        return CommonResult.successResponse();
    }
}
