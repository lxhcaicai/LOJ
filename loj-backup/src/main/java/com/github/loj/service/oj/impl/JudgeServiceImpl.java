package com.github.loj.service.oj.impl;

import com.github.loj.common.exception.*;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.oj.JudgeManager;
import com.github.loj.pojo.dto.SubmitJudgeDTO;
import com.github.loj.pojo.dto.TestJudgeDTO;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.vo.JudgeCaseVO;
import com.github.loj.pojo.vo.SubmissionInfoVO;
import com.github.loj.pojo.vo.TestJudgeVO;
import com.github.loj.service.oj.JudgeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.rmi.AccessException;

/**
 * @author lxhcaicai
 * @date 2023/5/6 22:05
 */
@Service
public class JudgeServiceImpl implements JudgeService {

    @Resource
    private JudgeManager judgeManager;

    @Override
    public CommonResult<String> submitProblemTestJudge(TestJudgeDTO testJudgeDTO) {
        try {
            return CommonResult.successResponse(judgeManager.submitProblemTestJudge(testJudgeDTO), "success");
        } catch (StatusForbiddenException|AccessException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusSystemErrorException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.SYSTEM_ERROR);
        }
    }

    @Override
    public CommonResult<TestJudgeVO> getTestJudgeResult(String testJudgeKey) {
        try {
            return CommonResult.successResponse(judgeManager.getTestJudgeResult(testJudgeKey));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Judge> submitProblemJudge(SubmitJudgeDTO judgeDTO) {
        try {
            return CommonResult.successResponse(judgeManager.submitProblemJudge(judgeDTO));
        } catch (StatusForbiddenException|AccessException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<SubmissionInfoVO> getSubmission(Long submitId) {
        try {
            return CommonResult.successResponse(judgeManager.getSubmission(submitId));
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        } catch (StatusAccessDeniedException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.ACCESS_DENIED);
        }
    }

    @Override
    public CommonResult<JudgeCaseVO> getALLCaseResult(Long submitId) {
        try {
            return CommonResult.successResponse(judgeManager.getALLCaseResult(submitId));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        }
    }
}
