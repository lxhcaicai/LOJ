package com.github.loj.judge;

import cn.hutool.core.io.resource.ResourceUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.github.loj.common.exception.RuntimeError;
import com.github.loj.judge.entity.LanguageConfig;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.internal.StringUtil;
import org.springframework.stereotype.Component;
import org.yaml.snakeyaml.Yaml;

import javax.annotation.PostConstruct;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * @author lxhcaicai
 * @date 2023/4/14 0:47
 */
@Component
@Slf4j(topic = "loj")
public class LanguageConfigLoader {

    private static List<String> defaultEnv = Arrays.asList(
            "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
            "LANG=en_US.UTF-8",
            "LC_ALL=en_US.UTF-8",
            "LANGUAGE=en_US:en",
            "HOME=/w"
    );

    private static List<String> python3Env = Arrays.asList("LANG=en_US.UTF-8",
            "LANGUAGE=en_US:en", "LC_ALL=en_US.UTF-8", "PYTHONIOENCODING=utf-8");

    private static AtomicBoolean init = new AtomicBoolean(false);

    private static HashMap<String, LanguageConfig> languageConfigMap;

    @PostConstruct
    public void init() {
        if(init.compareAndSet(false,true)) {
            Iterable<Object> languageConfigIter = loadYml("language.yml");
            languageConfigMap = new HashMap<>();
            for(Object configObj: languageConfigIter) {
                JSONObject configJson = JSONUtil.parseObj(configObj);
                LanguageConfig languageConfig = buildLanguageConfig(configJson);
            }
        }
    }

    private Iterable<Object> loadYml(String fileName){
        try {
            Yaml yaml = new Yaml();
            String ymlContent = ResourceUtil.readUtf8Str(fileName);
            return yaml.loadAll(ymlContent);
        } catch (Exception e) {
            log.error("load language yaml error:", e);
            throw new RuntimeException(e);
        }
    }

    private LanguageConfig buildLanguageConfig(JSONObject configJson) {
        LanguageConfig languageConfig = new LanguageConfig();
        languageConfig.setLanguage(configJson.getStr("language"));
        languageConfig.setSrcName(configJson.getStr("src_path"));
        languageConfig.setExeName(configJson.getStr("exe_path"));

        JSONObject compileJson = configJson.getJSONObject("compile");

        if(compileJson != null) {
            String command = compileJson.getStr("command");
            command = command.replace("{src_path}", languageConfig.getSrcName())
                    .replace("{exe_path}", languageConfig.getExeName());
            languageConfig.setCompileCommand(command);
            String env = compileJson.getStr("env");
            env = env.toLowerCase();
            switch (env) {
                case "python3":
                    languageConfig.setRunEnvs(python3Env);
                    break;
                default:
                    languageConfig.setRunEnvs(defaultEnv);
            }
            languageConfig.setMaxCpuTime(parseTimeStr(compileJson.getStr("maxCpuTime")));
            languageConfig.setMaxCpuTime(parseTimeStr(compileJson.getStr("maxRealTime")));
            languageConfig.setMaxCpuTime(parseMemoryStr(compileJson.getStr("maxMemory")));
        }

        JSONObject runJson = configJson.getJSONObject("run");
        if(runJson != null) {
            String command = runJson.getStr("command");
            command = command.replace("{exe_path}", languageConfig.getExeName());
            languageConfig.setRunCommand(command);
            String env = runJson.getStr("env");
            env = env.toLowerCase();
            switch (env) {
                case "python3":
                    languageConfig.setRunEnvs(python3Env);
                    break;
                default:
                    languageConfig.setRunEnvs(defaultEnv);
            }
        }
        return languageConfig;
    }

    private Long parseTimeStr(String timeStr) {
        if(StringUtil.isBlank(timeStr)) {
            return 3000L;
        }
        timeStr = timeStr.toLowerCase();
        if(timeStr.endsWith("s")) {
            return Long.parseLong(timeStr.replace("s","")) * 1000;
        } else if(timeStr.endsWith("ms")) {
            return Long.parseLong(timeStr.replace("s",""));
        } else {
            return Long.parseLong(timeStr);
        }
    }

    private Long parseMemoryStr(String memoryStr) {
        if(StringUtil.isBlank(memoryStr)) {
            return 256 * 1024 * 1024L;
        }
        memoryStr = memoryStr.toLowerCase();
        if(memoryStr.endsWith("mb")) {
            return Long.parseLong(memoryStr.replace("mb","")) * 1024 * 1024;
        } else if(memoryStr.endsWith("kb")) {
            return Long.parseLong(memoryStr.replace("kb","")) * 1024;
        } else if(memoryStr.endsWith("b")) {
            return Long.parseLong(memoryStr.replace("b",""));
        } else {
            return Long.parseLong(memoryStr) * 1024 * 1024;
        }
    }

}
