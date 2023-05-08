package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.SubmitJudgeDTO;
import com.github.loj.pojo.dto.TestJudgeDTO;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.vo.SubmissionInfoVO;
import com.github.loj.pojo.vo.TestJudgeVO;

/**
 * @author lxhcaicai
 * @date 2023/5/6 22:04
 */
public interface JudgeService {

    public CommonResult<String> submitProblemTestJudge(TestJudgeDTO testJudgeDTO);

    public CommonResult<TestJudgeVO> getTestJudgeResult(String testJudgeKey);

    public CommonResult<Judge> submitProblemJudge(SubmitJudgeDTO judgeDTO);

    public CommonResult<SubmissionInfoVO> getSubmission(Long submitId);
}
