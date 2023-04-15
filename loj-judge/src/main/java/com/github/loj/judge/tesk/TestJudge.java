package com.github.loj.judge.tesk;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.github.loj.common.exception.SystemError;
import com.github.loj.judge.SandboxRun;
import com.github.loj.judge.entity.JudgeDTO;
import com.github.loj.judge.entity.JudgeGlobalDTO;
import com.github.loj.judge.entity.LanguageConfig;
import com.github.loj.judge.entity.SandBoxRes;
import com.github.loj.util.Constants;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

/**
 * @author lxhcaicai
 * @date 2023/4/15 18:16
 */
@Component
public class TestJudge extends AbstractJudge{
    @Override
    public JSONArray judgeCase(JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO) throws SystemError {
        LanguageConfig runConfig = judgeGlobalDTO.getRunConfig();

        // 调用安全沙箱使用测试点对程序进行测试

        return SandboxRun.testCase(
                parseRunCommand(runConfig.getRunCommand(), null, null, null),
                runConfig.getRunEnvs(),
                judgeDTO.getTestCaseInputPath(),
                judgeDTO.getTestCaseInputContent(),
                judgeGlobalDTO.getTestTime(),
                judgeGlobalDTO.getMaxMemory(),
                judgeDTO.getMaxOutputSize(),
                judgeGlobalDTO.getMaxStack(),
                runConfig.getExeName(),
                judgeGlobalDTO.getUserFileId(),
                judgeGlobalDTO.getUserFileContent());
    }

    @Override
    public JSONObject checkResult(SandBoxRes sandBoxRes, JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO) throws SystemError {
        JSONObject result = new JSONObject();
        StringBuilder errMsg = new StringBuilder();

        // 如果测试跑题无异常
        if(sandBoxRes.getStatus().equals(Constants.Judge.STATUS_ACCEPTED.getStatus())) {
            // 对结果的时间损耗和空间损耗与题目限制做比较，判断是否mle和tle
            if(sandBoxRes.getTime() > judgeGlobalDTO.getMaxTime()) {
                result.set("status", Constants.Judge.STATUS_TIME_LIMIT_EXCEEDED.getStatus());
            } else if(sandBoxRes.getMemory() > judgeGlobalDTO.getMaxMemory() * 1024) {
                result.set("status", Constants.Judge.STATUS_MEMORY_LIMIT_EXCEEDED.getStatus());
            } else {

            }
        } else if(sandBoxRes.getExitCode() != 0) {
            result.set("status",Constants.Judge.STATUS_RUNTIME_ERROR.getStatus());
            if(sandBoxRes.getExitCode() < 32) {
                errMsg.append(String.format("ExitCode: %s (%s)\n", sandBoxRes.getExitCode(), SandboxRun.signals.get(sandBoxRes.getExitCode())));
            } else {
                errMsg.append(String.format("ExitCode: %s\n", sandBoxRes.getExitCode()));
            }
        } else {
            result.set("status", sandBoxRes.getStatus());
            // 输出超限的特别提示
            if("Output Limit Exceeded".equals(sandBoxRes.getOriginalStatus())) {
                errMsg.append("The output character length of the program exceeds the limit");
            }
        }

        // b
        result.set("memory", sandBoxRes.getMemory());

        // ns -> ms
        result.set("time", sandBoxRes.getTime());

        if(!StringUtils.isEmpty(sandBoxRes.getStderr())) {
            errMsg.append(sandBoxRes.getStderr());
        }
        // 记录该测试点的错误信息
        if(!StringUtils.isEmpty(errMsg.toString())) {
            String str = errMsg.toString();
            result.set("errMsg", str.substring(0, Math.min(1024 * 1024, str.length())));
        }

        // 记录该测试点的运行输出
        if(!StringUtils.isEmpty(sandBoxRes.getStdout()) && sandBoxRes.getStdout().length() > 1000) {
            result.set("output", sandBoxRes.getStdout().substring(0, 1000) + "...");
        } else {
            result.set("output", sandBoxRes.getStdout());
        }
        return result;
    }
}
