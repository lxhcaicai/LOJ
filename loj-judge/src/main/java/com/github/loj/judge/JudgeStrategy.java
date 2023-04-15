package com.github.loj.judge;

import com.github.loj.common.exception.CompileError;
import com.github.loj.common.exception.SubmitError;
import com.github.loj.common.exception.SystemError;
import com.github.loj.judge.entity.LanguageConfig;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import com.github.loj.util.Constants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/4/14 1:48
 */

@Component
@Slf4j(topic = "loj")
public class JudgeStrategy {

    @Resource
    private LanguageConfigLoader languageConfigLoader;

    @Resource
    private JudgeRun judgeRun;

    public TestJudgeRes testJudge(TestJudgeReq testJudgeReq) {
        // 编译好的临时代码文件id
        String userFileId = null;
        try{
            // 对源代码进行编译 获取tmpfs中的fileId
            LanguageConfig languageConfig = languageConfigLoader.getLanguageConfigByName(testJudgeReq.getLanguage());
            // 有的语言可能不支持编译,目前有js、php不支持编译，需要提供源代码
            if(languageConfig.getCompileCommand() != null) {
                userFileId = Compiler.compile(languageConfig,
                        testJudgeReq.getCode(),
                        testJudgeReq.getLanguage(),
                        testJudgeReq.getExtraFile());
            }
            return judgeRun.testJudgeCase(userFileId,testJudgeReq);
        } catch (SystemError systemError) {
            log.error("[Test Judge] [System Error] [{}]", systemError.toString());
            return TestJudgeRes.builder()
                    .memory(0L)
                    .time(0L)
                    .status(Constants.Judge.STATUS_COMPILE_ERROR.getStatus())
                    .stderr("Oops, something has gone wrong with the judgeServer. Please report this to administrator.")
                    .build();
        } catch (CompileError compileError) {
            return TestJudgeRes.builder()
                    .memory(0L)
                    .time(0L)
                    .status(Constants.Judge.STATUS_COMPILE_ERROR.getStatus())
                    .stderr(mergeNonEmptyStrings(compileError.getStderr(),compileError.getStderr()))
                    .build();
        } catch (SubmitError submitError) {
            log.error("[Test Judge] [Submit Error] [{}]", submitError.toString());
            return TestJudgeRes.builder()
                    .memory(0L)
                    .time(0L)
                    .status(Constants.Judge.STATUS_SUBMITTED_FAILED.getStatus())
                    .stderr(mergeNonEmptyStrings(submitError.getMessage(), submitError.getStdout(),submitError.getStderr()))
                    .build();
        } catch (Exception exception) {
            log.error("[Test Judge] [Error] [{}]", exception.toString());
            return TestJudgeRes.builder()
                    .memory(0L)
                    .time(0L)
                    .status(Constants.Judge.STATUS_SUBMITTED_FAILED.getStatus())
                    .stderr("Oops, something has gone wrong with the judgeServer. Please report this to administrator.")
                    .build();
        } finally{

            // 删除tmpfs内存中的用户代码可执行文件
            if(!StringUtils.isEmpty(userFileId)) {
                SandboxRun.delFile(userFileId);
            }
        }
    }

    public String mergeNonEmptyStrings(String... strings) {
        StringBuilder stringBuilder = new StringBuilder();
        for(String str: strings) {
            if(!StringUtils.isEmpty(str)) {
                stringBuilder.append(str.substring(0, Math.min(1024 * 1024, str.length()))).append("\n");
            }
        }
        return stringBuilder.toString();
    }
}
