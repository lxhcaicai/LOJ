package com.github.loj.judge;

import cn.hutool.extra.spring.SpringUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.github.loj.common.exception.CompileError;
import com.github.loj.common.exception.SubmitError;
import com.github.loj.common.exception.SystemError;
import com.github.loj.judge.entity.LanguageConfig;
import com.github.loj.util.Constants;
import com.github.loj.util.JudgeUtils;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/15 10:19
 */
public class Compiler {

    public static String compile(LanguageConfig languageConfig, String code,
                                 String language, HashMap<String,String > extraFiles) throws SystemError, CompileError, SubmitError {
        if(languageConfig == null) {
            throw new RuntimeException("Unsupported language " + language);

        }

        // 调用安全沙箱进行编译
        JSONArray result = SandboxRun.compile(languageConfig.getMaxCpuTime(),
                languageConfig.getMaxRealTime(),
                languageConfig.getMaxMemory(),
                256 * 1024 * 1024L,
                languageConfig.getSrcName(),
                languageConfig.getExeName(),
                parseCompileCommand(languageConfig.getCompileCommand()),
                languageConfig.getCompileEnvs(),
                code,
                extraFiles,
                true,
                false,
                null
                );
        JSONObject compileResult = (JSONObject) result.get(0);
        if(compileResult.getInt("status").intValue() != Constants.Judge.STATUS_ACCEPTED.getStatus()) {
            throw  new CompileError("Compile Error.", ((JSONObject)compileResult.get("files")).getStr("stdout"),
                    ((JSONObject)compileResult.get("files")).getStr("stderr"));
        }

        String fileId = ((JSONObject)compileResult.get("fileIds")).getStr(languageConfig.getExeName());
        if(StringUtils.isEmpty(fileId)) {
            throw new SubmitError("Executable file not found.", ((JSONObject)compileResult.get("files")).getStr("stdout"),
                    ((JSONObject)compileResult.get("files")).getStr("stderr"));
        }

        return fileId;
    }

    private static List<String> parseCompileCommand(String command) {
        return JudgeUtils.translateCommandline(command);
    }

    public static Boolean compileSpj(String code, Long pid, String language, HashMap<String,String> extraFiles) throws SystemError {
        LanguageConfigLoader languageConfigLoader = SpringUtil.getBean(LanguageConfigLoader.class);
        LanguageConfig languageConfig = languageConfigLoader.getLanguageConfigByName("SPJ-" + language);

        if(languageConfig == null) {
            throw new RuntimeException("Unsupported SPJ language:" + language);
        }

        boolean copyOutExe = true;
        if(pid == null) { // 题目id为空，则不进行本地存储，可能为新建题目时测试特判程序是否正常的判断而已
            copyOutExe = false;
        }

        // 调用安全沙箱对特别判题程序进行编译
        JSONArray res = SandboxRun.compile(languageConfig.getMaxCpuTime(),
                languageConfig.getMaxRealTime(),
                languageConfig.getMaxMemory(),
                256 * 1024 * 1024L,
                languageConfig.getSrcName(),
                languageConfig.getExeName(),
                parseCompileCommand(languageConfig.getCompileCommand()),
                languageConfig.getCompileEnvs(),
                code,
                extraFiles,
                false,
                copyOutExe,
                Constants.JudgeDir.SPJ_WORKPLACE_DIR.getContent() + "/" + pid);

        JSONObject compileResult = (JSONObject) res.get(0);
        if(compileResult.getInt("status").intValue() != Constants.Judge.STATUS_ACCEPTED.getStatus()) {
            throw  new SystemError("Special Judge Code Compile Error.", ((JSONObject) compileResult.get("files")).getStr("stdout"),
                    ((JSONObject) compileResult.get("files")).getStr("stderr"));
        }
        return true;
    }

    public static Boolean compileInteractive(String code, Long pid, String language, HashMap<String,String> extraFiles) throws SystemError {
        LanguageConfigLoader languageConfigLoader = SpringUtil.getBean(LanguageConfigLoader.class);
        LanguageConfig languageConfig = languageConfigLoader.getLanguageConfigByName("INTERACTIVE-" + language);

        if(languageConfig == null) {
            throw new RuntimeException("Unsupported interactive language:" + language);
        }

        boolean copyOutExe = true;
        if(pid == null) { // 题目id为空，则不进行本地存储，可能为新建题目时测试特判程序是否正常的判断而已
            copyOutExe = false;
        }

        // 调用安全沙箱对特别判题程序进行编译
        JSONArray res = SandboxRun.compile(languageConfig.getMaxCpuTime(),
                languageConfig.getMaxRealTime(),
                languageConfig.getMaxMemory(),
                256 * 1024 * 1024L,
                languageConfig.getSrcName(),
                languageConfig.getExeName(),
                parseCompileCommand(languageConfig.getCompileCommand()),
                languageConfig.getCompileEnvs(),
                code,
                extraFiles,
                false,
                copyOutExe,
                Constants.JudgeDir.INTERACTIVE_WORKPLACE_DIR.getContent() + "/" + pid);

        JSONObject compileResult = (JSONObject) res.get(0);
        if(compileResult.getInt("status").intValue() != Constants.Judge.STATUS_ACCEPTED.getStatus()) {
            throw new SystemError("Interactive Judge Code Compile Error.", ((JSONObject) compileResult.get("files")).getStr("stdout"),
                    ((JSONObject) compileResult.get("files")).getStr("stderr"));
        }
        return true;
    }
}
