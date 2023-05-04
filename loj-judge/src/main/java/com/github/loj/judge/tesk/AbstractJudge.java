package com.github.loj.judge.tesk;

import cn.hutool.core.util.ReUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.github.loj.common.exception.SystemError;
import com.github.loj.judge.entity.JudgeDTO;
import com.github.loj.judge.entity.JudgeGlobalDTO;
import com.github.loj.judge.entity.SandBoxRes;
import com.github.loj.util.Constants;
import com.github.loj.util.JudgeUtils;
import org.springframework.util.StringUtils;

import java.io.File;
import java.util.List;
import java.util.regex.Pattern;

/**
 * @author lxhcaicai
 * @date 2023/4/15 18:18
 */
public abstract class AbstractJudge {

    protected static final int SPJ_PC = 99;

    protected static final int SPJ_AC = 100;

    protected static final int SPJ_PE = 101;

    protected static final int SPJ_WA = 102;

    protected static final int SPJ_ERROR = 103;

    private final static Pattern EOL_PATTERN = Pattern.compile("[^\\s\\n]+(?==\\n)");


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

    protected JSONObject parseTestLibErr(String msg) {
        JSONObject res = new JSONObject(2);
        String output = msg.substring(0,Math.min(1024, msg.length()));
        if(output.startsWith("ok ")) {
            res.set("code", SPJ_AC);
            res.set("errMsg", output.split("ok ")[1]);
        } else if(output.startsWith("wrong answer ")) {
            res.set("code", SPJ_WA);
            res.set("errMsg", output.split("wrong answer ")[1]);
        } else if (output.startsWith("partially correct ")) {
            res.set("errMsg", output.split("partially correct ")[1]);
            String numStr = ReUtil.get("partially correct \\(([\\s\\S]*?)\\) ", output, 1);
            double percentage = 0.0;
            if(!StringUtils.isEmpty(numStr)) {
                percentage = Integer.parseInt(numStr) * 1.0 / 100;
            }
            res.set("percentage", percentage);
            res.set("code", SPJ_PC);
        } else if  (output.startsWith("points ")) {
            res.set("code", SPJ_PC);
            String numStr = output.split("points ")[1].split(" ")[0];
            double percentage = 0.0;
            if(!StringUtils.isEmpty(numStr)) {
                percentage = Integer.parseInt(numStr) * 1.0 / 100;
            }
            if(percentage == 1) {
                res.set("code", SPJ_AC);
            } else {
                res.set("percentage", percentage);
            }
            String tmp = output.split("points ")[1];
            res.set("errMsg", tmp.substring(0, Math.min(1024, tmp.length())));
        } else if (output.startsWith("FAIL ")) {
            res.set("code", SPJ_ERROR);
            res.set("errMsg", output.split("FAIL ")[1]);
        } else {
            res.set("code", SPJ_ERROR);
            res.set("errMsg", output);
        }
        return res;
    }

    public abstract JSONObject checkMultipleResult(SandBoxRes userSandBoxRes, SandBoxRes interactiveSandBoxRes, JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO);

    // 去除行末尾空白符
    protected String rtrim(String str) {
        if(str == null) return null;
        return EOL_PATTERN.matcher(StrUtil.trimEnd(str)).replaceAll("");
    }
}
