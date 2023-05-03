package com.github.loj.controller;

import com.github.loj.common.CommonResult;
import com.github.loj.common.ResultStatus;
import com.github.loj.common.exception.SystemError;
import com.github.loj.pojo.dto.CompileDTO;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import com.github.loj.dao.JudgeServerEntityService;
import com.github.loj.pojo.dto.ToJudgeDTO;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.service.JudgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/4/13 1:19
 */
@RestController
@RefreshScope
public class JudgeController {

    @Autowired
    private JudgeService judgeService;

    @Value("${loj-judge-server.remote-judge.open}")
    private Boolean openRemoteJudge;

    @Autowired
    private JudgeServerEntityService judgeServerEntityService;

    @RequestMapping("/version")
    public CommonResult<HashMap<String,Object>> getVersion() {
        return CommonResult.successResponse(judgeServerEntityService.getJudgeServerInfo(), "运行正常");
    }

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
        return CommonResult.successResponse(judgeService.testJudge(testJudgeReq));
    }

    @PostMapping(value = "/compile-spj")
    public CommonResult<Void> compileSpj(@RequestBody CompileDTO compileDTO) {
        try {
            judgeService.compileSpj(compileDTO.getCode(), compileDTO.getPid(), compileDTO.getLanguage(), compileDTO.getExtraFiles());
            return CommonResult.successResponse(null, "编译成功!");
        } catch (SystemError systemError) {
            return CommonResult.errorResponse(systemError.getStderr(), ResultStatus.SYSTEM_ERROR);
        }
    }

    @PostMapping(value = "/compile-interactive")
    public CommonResult<Void> compileInteractive(@RequestBody CompileDTO compileDTO) {
        try {
            judgeService.compileInteractive(compileDTO.getCode(), compileDTO.getPid(), compileDTO.getLanguage(), compileDTO.getExtraFiles());
            return CommonResult.successResponse(null, "编译成功!");
        } catch (SystemError systemError) {
            return CommonResult.errorResponse(systemError.getStderr(), ResultStatus.SYSTEM_ERROR);
        }
    }

    @PostMapping(value = "/judge")
    public CommonResult<Void> submitProblemJudge(@RequestBody ToJudgeDTO toJudgeDTO) {

        Judge judge = toJudgeDTO.getJudge();
        if(judge == null || judge.getSubmitId() == null || judge.getUid() == null || judge.getPid() == null) {
            return CommonResult.errorResponse("调用参数错误！请检查您的调用参数！");
        }
        judgeService.judge(judge);
        return CommonResult.successResponse("判题机评测完成！");
    }

    @PostMapping(value = "/remote-judge")
    public CommonResult<Void> remoteJudge(@RequestBody ToJudgeDTO toJudgeDTO) {
        if(!openRemoteJudge) {
            return CommonResult.errorResponse("对不起！该判题服务器未开启远程虚拟判题功能！", ResultStatus.ACCESS_DENIED);
        }

        if(toJudgeDTO.getJudge() == null) {
            return CommonResult.errorResponse("请求参数不能为空");
        }

        judgeService.remoteJudge(toJudgeDTO);

        return CommonResult.successResponse("提交成功");

    }
}
