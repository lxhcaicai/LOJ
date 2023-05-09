package com.github.loj.service.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.SubmitIdListDTO;
import com.github.loj.pojo.dto.SubmitJudgeDTO;
import com.github.loj.pojo.dto.TestJudgeDTO;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.vo.JudgeCaseVO;
import com.github.loj.pojo.vo.JudgeVO;
import com.github.loj.pojo.vo.SubmissionInfoVO;
import com.github.loj.pojo.vo.TestJudgeVO;

import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/5/6 22:04
 */
public interface JudgeService {

    public CommonResult<String> submitProblemTestJudge(TestJudgeDTO testJudgeDTO);

    public CommonResult<TestJudgeVO> getTestJudgeResult(String testJudgeKey);

    public CommonResult<Judge> submitProblemJudge(SubmitJudgeDTO judgeDTO);

    public CommonResult<SubmissionInfoVO> getSubmission(Long submitId);

    public CommonResult<JudgeCaseVO> getALLCaseResult(Long submitId);

    public CommonResult<IPage<JudgeVO>> getJudgeList(Integer limit,
                                                     Integer currentPage,
                                                     Boolean onlyMine,
                                                     String searchPid,
                                                     Integer searchStatus,
                                                     String searchUsername,
                                                     Boolean completeProblemID,
                                                     Long gid);
    public CommonResult<Void> updateSubmission(Judge judge);

    public CommonResult<HashMap<Long,Object>> checkCommonJudgeResult(SubmitIdListDTO submitIdListDTO);

    public CommonResult<Judge> resubmit(Long submitId);
}
