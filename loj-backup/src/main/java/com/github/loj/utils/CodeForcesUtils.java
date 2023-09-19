package com.github.loj.utils;

import cn.hutool.core.io.resource.ResourceUtil;
import cn.hutool.core.util.ReUtil;
import cn.hutool.http.HttpRequest;
import lombok.extern.slf4j.Slf4j;

import javax.script.*;
import java.util.ArrayList;
import java.util.List;

@Slf4j(topic = "loj")
public class CodeForcesUtils {
    private static String RCPC;

    public static String getRCPC() {
        if(RCPC == null) {
            HttpRequest request = HttpRequest.get("https://codeforces.com")
                    .timeout(20000);
            String html = request.execute().body();
            List<String> list = ReUtil.findAll("[a-z0-9]+[a-z0-9]{31}", html, 0, new ArrayList<>());
            updateRCPC(list);
        }
        return RCPC;
    }

    public static void updateRCPC(List<String> list) {
        ScriptEngine se = new ScriptEngineManager().getEngineByName("javascript");
        Bindings bindings = se.createBindings();
        bindings.put("string", 4);
        se.setBindings(bindings, ScriptContext.ENGINE_SCOPE);

        String file = ResourceUtil.readUtf8Str("CodeForcesAES.js");
        try {
            se.eval(file);
            // 是否可调用
            if (se instanceof Invocable) {
                Invocable in = (Invocable) se;
                RCPC = (String) in.invokeFunction("getRCPC", list.get(0), list.get(1), list.get(2));
            }
        } catch (ScriptException e) {
            log.error("CodeForcesUtils.updateRCPC throw ScriptException ->", e);
        } catch (NoSuchMethodException e) {
            log.error("CodeForcesUtils.updateRCPC throw NoSuchMethodException ->", e);
        }
    }
}
