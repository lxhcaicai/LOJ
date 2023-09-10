package com.github.loj.judge.tesk;

import cn.hutool.core.util.NumberUtil;
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

import java.io.File;

/**
 * @author lxhcaicai
 * @date 2023/5/2 10:51
 */
@Component
public class InteractiveJudge extends AbstractJudge{
    @Override
    public JSONArray judgeCase(JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO) throws SystemError {
        LanguageConfig runConfig = judgeGlobalDTO.getRunConfig();
        LanguageConfig interactiveRunConfig = judgeGlobalDTO.getInteractiveRunConfig();

        String interactiveExeSrc = Constants.JudgeDir.INTERACTIVE_WORKPLACE_DIR.getContent()
                + "/" + judgeGlobalDTO.getProblemId() + "/" + interactiveRunConfig.getExeName();

        String testCaseInputFileName = judgeGlobalDTO.getProblemId() + "_input";
        String testCaseOutputFileName = judgeGlobalDTO.getProblemId() + "_output";

        String userOutputFileName = judgeGlobalDTO.getProblemId() + "_user_output";

        return SandboxRun.interactiveTestCase(
                parseRunCommand(runConfig.getRunCommand(), null, null, null),
                runConfig.getRunEnvs(),
                runConfig.getExeName(),
                judgeGlobalDTO.getUserFileId(),
                judgeGlobalDTO.getUserFileContent(),
                judgeGlobalDTO.getTestTime(),
                judgeGlobalDTO.getMaxMemory(),
                judgeGlobalDTO.getMaxStack(),
                judgeDTO.getTestCaseInputPath(),
                testCaseInputFileName,
                judgeDTO.getTestCaseOutputFileName(),
                testCaseOutputFileName,
                userOutputFileName,
                parseRunCommand(interactiveRunConfig.getRunCommand(), testCaseInputFileName, userOutputFileName, testCaseOutputFileName),
                interactiveRunConfig.getRunEnvs(),
                interactiveExeSrc,
                interactiveRunConfig.getExeName());
    }

    @Override
    public JSONObject checkResult(SandBoxRes sandBoxRes, JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO) throws SystemError {
        // TODO
        return null;
    }

    @Override
    public JSONObject checkMultipleResult(SandBoxRes userSandBoxRes, SandBoxRes interactiveSandBoxRes, JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO) {
        JSONObject result = new JSONObject();

        // 记录错误信息
        StringBuilder errMsg = new StringBuilder();

        int userExitCode = userSandBoxRes.getExitCode();
        result.set("status", userSandBoxRes.getStatus());
        // 如果运行超过题目限制时间，直接TLE
        if(userSandBoxRes.getMemory() > judgeGlobalDTO.getMaxTime()) {
            result.set("status", Constants.Judge.STATUS_TIME_LIMIT_EXCEEDED.getStatus());
        } else if(userSandBoxRes.getMemory() > judgeGlobalDTO.getMaxMemory() * 1024) {
            result.set("status", Constants.Judge.STATUS_MEMORY_LIMIT_EXCEEDED.getStatus());
        } else if((userExitCode != 0 && userExitCode != 13) || (userExitCode == 13 && interactiveSandBoxRes.getExitCode() == 0)) {
            result.set("status", Constants.Judge.STATUS_RUNTIME_ERROR.getStatus());
            if(userExitCode < 32) {
                errMsg.append(String.format("The program return exit status code: %s (%s)\n", userExitCode, SandboxRun.signals.get(userExitCode)));
            } else {
                errMsg.append(String.format("The program return exit status code: %s\n", userExitCode));
            }
        } else {
            JSONObject interactiveCheckRes = checkInteractiveRes(interactiveSandBoxRes);
            int code = interactiveCheckRes.getInt("code");
            if(code == SPJ_WA) {
                result.set("status", Constants.Judge.STATUS_WRONG_ANSWER.getStatus());
            } else if(code == SPJ_AC) {
                result.set("status", Constants.Judge.STATUS_ACCEPTED.getStatus());
            } else if(code == SPJ_PE) {
                result.set("status", Constants.Judge.STATUS_PRESENTATION_ERROR.getStatus());
            } else if(code == SPJ_PC) {
                result.set("status", Constants.Judge.STATUS_PARTIAL_ACCEPTED.getStatus());
                result.set("percentage", interactiveCheckRes.getDouble("percentage"));
            } else {
                result.set("status", Constants.Judge.STATUS_SYSTEM_ERROR.getStatus());
            }

            String spjErrMsg = interactiveCheckRes.getStr("errMsg");
            if(!StringUtils.isEmpty(spjErrMsg)) {
                errMsg.append(spjErrMsg).append(" ");
            }

            if(interactiveSandBoxRes.getExitCode() != 0 && StringUtils.isEmpty(interactiveSandBoxRes.getStderr())) {
                errMsg.append(String.format("Interactive program exited with code: %s", interactiveSandBoxRes.getExitCode()));
            }
        }

        // kb
        result.set("memory", userSandBoxRes.getMemory());

        // ms
        result.set("time", userSandBoxRes.getTime());

        // 记录该测试点的错误信息
        if(!StringUtils.isEmpty(errMsg.toString())) {
            String str = errMsg.toString();
            result.set("errMsg", str.substring(0, Math.min(1024 * 1024, str.length())));
        }

        return result;
    }

    private JSONObject checkInteractiveRes(SandBoxRes interactiveSandBoxRes) {
        JSONObject result = new JSONObject();

        int exitCode = interactiveSandBoxRes.getExitCode();

        // 获取跑题用户输出或错误输出
        if(!StringUtils.isEmpty(interactiveSandBoxRes.getStderr())) {
            result.set("errMsg", interactiveSandBoxRes.getStderr());
        }

        // 如果程序无异常
        if(interactiveSandBoxRes.getStatus().equals(Constants.Judge.STATUS_ACCEPTED.getStatus())) {
            if(exitCode == Constants.Judge.STATUS_ACCEPTED.getStatus()) {
                result.set("code", SPJ_AC);
            } else {
                result.set("code", exitCode);
            }
        } else if(interactiveSandBoxRes.getStatus().equals(Constants.Judge.STATUS_RUNTIME_ERROR.getStatus())) {
            if(exitCode == SPJ_WA || exitCode == SPJ_ERROR || exitCode == SPJ_AC || exitCode == SPJ_PE) {
                result.set("code", exitCode);
            } else if(exitCode == SPJ_PC) {
                result.set("code", exitCode);
                String stdout = interactiveSandBoxRes.getStdout();
                if(NumberUtil.isNumber(stdout)) {
                    double percentage = 0.0;
                    percentage = Double.parseDouble(stdout) / 100;
                    if(percentage == 1) {
                        result.set("code", SPJ_AC);
                    } else {
                        result.set("percentage", percentage);
                    }
                }
            } else {
                if(!StringUtils.isEmpty(interactiveSandBoxRes.getStderr())) {
                    // 适配testlib.h 根据错误信息前缀判断
                    return parseTestLibErr(interactiveSandBoxRes.getStderr());
                } else {
                    result.set("code", SPJ_ERROR);
                }
            }
        } else {
            result.set("code", SPJ_ERROR);
        }
        return result;
    }

}
