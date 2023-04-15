package com.github.loj.judge.tesk;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.github.loj.common.exception.SystemError;
import com.github.loj.judge.entity.JudgeDTO;
import com.github.loj.judge.entity.JudgeGlobalDTO;
import com.github.loj.judge.entity.SandBoxRes;
import com.github.loj.util.Constants;
import com.github.loj.util.JudgeUtils;

import java.io.File;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/15 18:18
 */
public abstract class AbstractJudge {
    public JSONObject judge(JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO) throws SystemError {
        JSONArray judgeResultList = judgeCase(judgeDTO, judgeGlobalDTO);

        switch (judgeGlobalDTO.getJudgeMode()) {
            case SPJ:
            case TEST:
            case DEFAULT:
                return process(judgeDTO,judgeGlobalDTO,judgeResultList);
            default:
                throw new RuntimeException("The problem modle is error:" + judgeGlobalDTO.getJudgeMode());
        }
    }

    public abstract JSONArray judgeCase(JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO) throws SystemError;

    private JSONObject process(JudgeDTO judgeDTO,JudgeGlobalDTO judgeGlobalDTO, JSONArray judgeResultList) throws SystemError {
        JSONObject judgeResult = (JSONObject) judgeResultList.get(0);
        SandBoxRes sandBoxRes = SandBoxRes.builder()
                .stdout(((JSONObject)judgeResult.get("files")).getStr("stdout"))
                .stderr(((JSONObject)judgeResult.get("files")).getStr("stderr"))
                .time(judgeResult.getLong("time") / 1000000) // ns -> ms
                .memory(judgeResult.getLong("memory") / 1024)
                .exitCode(judgeResult.getInt("exitStatus"))
                .status(judgeResult.getInt("status"))
                .originalStatus(judgeResult.getStr("originalStatus"))
                .build();
        return checkResult(sandBoxRes,judgeDTO, judgeGlobalDTO);
    }

    public abstract JSONObject checkResult(SandBoxRes sandBoxRes, JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO) throws SystemError;

    protected static List<String> parseRunCommand(String command,
                                                  String testCaseInputName,
                                                  String userOutputName,
                                                  String testCaseOutputName) {
        if(testCaseInputName != null) {
            command = command.replace("{std_input}",
                    Constants.JudgeDir.TMPFS_DIR.getContent() + File.separator + testCaseInputName);
        }

        if(userOutputName != null) {
            command = command.replace("{user_output}",
                    Constants.JudgeDir.TMPFS_DIR.getContent() + File.separator + userOutputName);
        }

        if(userOutputName != null) {
            command = command.replace("{std_output}",
                    Constants.JudgeDir.TMPFS_DIR.getContent() + File.separator + testCaseInputName);
        }

        return JudgeUtils.translateCommandline(command);
    }
}
