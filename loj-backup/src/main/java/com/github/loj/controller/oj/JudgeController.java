package com.github.loj.controller.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.TestJudgeDTO;
import com.github.loj.service.oj.JudgeService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
