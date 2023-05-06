package com.github.loj.validator;

import com.github.loj.annotation.LOJAccessEnum;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.pojo.dto.SubmitJudgeDTO;
import com.github.loj.pojo.dto.TestJudgeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.annotation.PostConstruct;
import java.rmi.AccessException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/6 22:12
 */
@Component
public class JudgeValidator {
    @Autowired
    private AccessValidator accessValidator;

    private final static List<String> LOJ_LANGUAGE_LIST = Arrays.asList(
            "C++", "C++ With O2", "C++ 17", "C++ 17 With O2","C++ 20", "C++ 20 With O2",
            "C", "C With O2", "Python3", "Python2", "Java", "Golang", "C#", "PHP", "PyPy2", "PyPy3",
            "JavaScript Node", "JavaScript V8");

    private static HashMap<String,String> MODE_MAP_LANGUAGE;

    @PostConstruct
    public void init() {
        MODE_MAP_LANGUAGE = new HashMap<>();
        MODE_MAP_LANGUAGE.put("text/x-c++src", "C++ With O2");
        MODE_MAP_LANGUAGE.put("text/x-csrc", "C With O2");
        MODE_MAP_LANGUAGE.put("text/x-java", "Java");
        MODE_MAP_LANGUAGE.put("text/x-go", "Golang");
        MODE_MAP_LANGUAGE.put("text/x-csharp", "C#");
        MODE_MAP_LANGUAGE.put("text/x-php", "PHP");
    }

    public void validateSubmissionInfo(SubmitJudgeDTO submitJudgeDTO) throws AccessException, StatusFailException {
        if(submitJudgeDTO.getGid() != null) {
            accessValidator.validateAccess(LOJAccessEnum.GROUP_JUDGE);
        } else if(submitJudgeDTO.getCid() != null && submitJudgeDTO.getCid() != 0) {
            accessValidator.validateAccess(LOJAccessEnum.CONTEST_JUDGE);
        } else {
            accessValidator.validateAccess(LOJAccessEnum.PUBLIC_JUDGE);
        }

        if(!submitJudgeDTO.getIsRemote() && !LOJ_LANGUAGE_LIST.contains(submitJudgeDTO.getLanguage())) {
            throw new StatusFailException("提交的代码的语言错误！请使用" + LOJ_LANGUAGE_LIST + "中之一的语言！");
        }

        if(submitJudgeDTO.getCode().length() < 50
                && !submitJudgeDTO.getLanguage().contains("Py")
                && !submitJudgeDTO.getLanguage().contains("PHP")
                && !submitJudgeDTO.getLanguage().contains("JavaScript")) {
            throw new StatusFailException("提交的代码是无效的，代码字符长度请不要低于50！");
        }

        if(submitJudgeDTO.getCode().length() > 65535) {
            throw new StatusFailException("提交的代码是无效的，代码字符长度请不要超过65535！");
        }
    }

    public void validateTestJudgeInfo(TestJudgeDTO testJudgeDTO) throws AccessException, StatusFailException {
        String type = testJudgeDTO.getType();
        switch (type) {
            case "public":
                accessValidator.validateAccess(LOJAccessEnum.PUBLIC_JUDGE);
                break;
            case "contest":
                accessValidator.validateAccess(LOJAccessEnum.CONTEST_JUDGE);
                break;
            case "group":
                accessValidator.validateAccess(LOJAccessEnum.GROUP_JUDGE);
                break;
            default:
                throw new StatusFailException("请求参数type错误！");
        }

        if(StringUtils.isEmpty(testJudgeDTO.getCode())) {
            throw new StatusFailException("在线调试的代码不可为空！");
        }

        if(StringUtils.isEmpty(testJudgeDTO.getLanguage())) {
            throw new StatusFailException("在线调试的编程语言不可为空！");
        }

        // Remote Judge的编程语言需要转换成LOJ的编程语言才能进行自测
        if(testJudgeDTO.getIsRemoteJudge() != null && testJudgeDTO.getIsRemoteJudge()) {
            String language = MODE_MAP_LANGUAGE.get(testJudgeDTO.getMode());

            String dtoLanguage = testJudgeDTO.getLanguage();
            if (dtoLanguage.contains("PyPy 3") || dtoLanguage.contains("PyPy3")) {
                testJudgeDTO.setLanguage("PyPy3");
            } else if (dtoLanguage.contains("PyPy")) {
                testJudgeDTO.setLanguage("PyPy2");
            } else if (dtoLanguage.contains("Python 3")) {
                testJudgeDTO.setLanguage("Python3");
            } else if (dtoLanguage.contains("Python")) {
                testJudgeDTO.setLanguage("Python2");
            }else if (dtoLanguage.contains("Node")){
                testJudgeDTO.setLanguage("JavaScript Node");
            }else if (dtoLanguage.contains("JavaScript")){
                testJudgeDTO.setLanguage("JavaScript V8");
            }
        }

        if(!LOJ_LANGUAGE_LIST.contains(testJudgeDTO.getLanguage())) {
            throw new StatusFailException("提交的代码的语言错误！请使用" + LOJ_LANGUAGE_LIST + "中之一的语言！");
        }

        if(StringUtils.isEmpty(testJudgeDTO.getUserInput())) {
            throw new StatusFailException("在线调试的输入数据不可为空！");
        }

        if(testJudgeDTO.getUserInput().length() > 1000) {
            throw new StatusFailException("在线调试的输入数据字符长度不能超过1000！");
        }

        if(testJudgeDTO.getPid() == null) {
            throw new StatusFailException("在线调试所属题目的id不能为空！");
        }

        if(testJudgeDTO.getCode().length() < 50
                && !testJudgeDTO.getLanguage().contains("Py")
                && !testJudgeDTO.getLanguage().contains("PHP")
                && !testJudgeDTO.getLanguage().contains("JavaScript")) {
            throw new StatusFailException("提交的代码是无效的，代码字符长度请不要低于50！");
        }

        if(testJudgeDTO.getCode().length() > 65535) {
            throw new StatusFailException("提交的代码是无效的，代码字符长度请不要超过65535！");
        }
    }
}
