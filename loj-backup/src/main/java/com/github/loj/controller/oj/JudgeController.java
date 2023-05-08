package com.github.loj.controller.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.SubmitJudgeDTO;
import com.github.loj.pojo.dto.TestJudgeDTO;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.vo.JudgeCaseVO;
import com.github.loj.pojo.vo.JudgeVO;
import com.github.loj.pojo.vo.SubmissionInfoVO;
import com.github.loj.pojo.vo.TestJudgeVO;
import com.github.loj.service.oj.JudgeService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author lxhcaicai
 * @date 2023/5/6 21:19
 */
@RestController
@RequestMapping("/api")
public class JudgeController {

    @Autowired
    private JudgeService judgeService;

    @RequiresPermissions("submit")
    @RequiresAuthentication
    @RequestMapping("/submit-problem-test-judge")
    public CommonResult<String> submitProblemTestJudge(@RequestBody TestJudgeDTO testJudgeDTO) {
        return judgeService.submitProblemTestJudge(testJudgeDTO);
    }

    @RequiresAuthentication
    @GetMapping("/get-test-judge-result")
    public CommonResult<TestJudgeVO> getTestJudgeResult(@RequestParam("testJudgeKey") String testJudgeKey) {
        return judgeService.getTestJudgeResult(testJudgeKey);
    }

    @RequiresAuthentication
    @RequiresPermissions("submit")
    @RequestMapping(value = "/submit-problem-judge", method = RequestMethod.POST)
    public CommonResult<Judge> submitProblemJudge(@RequestBody SubmitJudgeDTO judgeDTO) {
        return judgeService.submitProblemJudge(judgeDTO);
    }


    /**
     * 获取单个的提交记录
     * @param submitId
     * @return
     */
    @GetMapping("/get-submission-detail")
    @AnonApi
    public CommonResult<SubmissionInfoVO> getSubmission(@RequestParam(value = "submitId", required = true) Long submitId) {
        return judgeService.getSubmission(submitId);
    }

    /**
     * 获得指定提交id的测试样例结果，暂不支持查看测试数据，只可看测试点结果，时间，空间，或者IO得分
     * @param submitId
     * @return
     */
    @GetMapping("/get-all-case-result")
    @AnonApi
    public CommonResult<JudgeCaseVO> getALLCaseResult(@RequestParam(value = "submitId", required = true) Long submitId) {
        return judgeService.getALLCaseResult(submitId);
    }


    /**
     * 通用查询判题记录列表
     * @param limit
     * @param currentPage
     * @param onlyMine
     * @param searchPid
     * @param searchStatus
     * @param searchUsername
     * @param completeProblemID
     * @param gid
     * @return
     */
    @GetMapping("/get-submission-list")
    @AnonApi
    public CommonResult<IPage<JudgeVO>> getJudgeList(@RequestParam(value = "limit", required = false)Integer limit,
                                                     @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                     @RequestParam(value = "onlyMine", required = false) Boolean onlyMine,
                                                     @RequestParam(value = "problemID", required = false) String searchPid,
                                                     @RequestParam(value = "status",required = false) Integer searchStatus,
                                                     @RequestParam(value = "username",required = false) String searchUsername,
                                                     @RequestParam(value = "completeProblemID", defaultValue = "false") Boolean completeProblemID,
                                                     @RequestParam(value = "gid",required = false) Long gid) {
        return judgeService.getJudgeList(limit,currentPage, onlyMine, searchPid, searchStatus, searchUsername, completeProblemID, gid);
    }
}
