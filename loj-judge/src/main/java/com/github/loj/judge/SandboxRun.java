package com.github.loj.judge;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.github.loj.common.exception.SystemError;
import com.github.loj.util.Constants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestClientResponseException;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/4/15 11:14
 */


@Slf4j(topic = "loj")
public class SandboxRun {
    private static final RestTemplate restTemplate;

    // 单例模式
    private static final SandboxRun instance = new SandboxRun();

    private static final String SANDBOX_BASE_URL = "http://localhost:5050";

    public static final HashMap<String,Integer> RESULT_MAP_STATUS = new HashMap<>();

    private static final int maxProcessNumber = 128;

    private static final  int TIME_LIMIT_MS = 16000;

    private static final int MEMORY_LIMIT_MB = 512;

    private static final int STACK_LIMIT_MB = 128;

    private static final int STDIO_SIZE_MB = 32;

    private SandboxRun() {

    }

    static {
        SimpleClientHttpRequestFactory requestFactory = new SimpleClientHttpRequestFactory();
        requestFactory.setConnectTimeout(200000);
        restTemplate = new RestTemplate(requestFactory);
    }
    static {
        RESULT_MAP_STATUS.put("Time Limit Exceeded", Constants.Judge.STATUS_TIME_LIMIT_EXCEEDED.getStatus());
        RESULT_MAP_STATUS.put("Memory Limit Exceeded", Constants.Judge.STATUS_MEMORY_LIMIT_EXCEEDED.getStatus());
        RESULT_MAP_STATUS.put("Output Limit Exceeded", Constants.Judge.STATUS_RUNTIME_ERROR.getStatus());
        RESULT_MAP_STATUS.put("Accepted", Constants.Judge.STATUS_ACCEPTED.getStatus());
        RESULT_MAP_STATUS.put("Nonzero Exit Status", Constants.Judge.STATUS_RUNTIME_ERROR.getStatus());
        RESULT_MAP_STATUS.put("Internal Error", Constants.Judge.STATUS_SYSTEM_ERROR.getStatus());
        RESULT_MAP_STATUS.put("File Error", Constants.Judge.STATUS_SYSTEM_ERROR.getStatus());
        RESULT_MAP_STATUS.put("Signalled", Constants.Judge.STATUS_RUNTIME_ERROR.getStatus());
    }

    public static RestTemplate getRestTemplate() {
        return restTemplate;
    }

    public static String getSandboxBaseUrl() {
        return SANDBOX_BASE_URL;
    }

    public static final List<String> signals = Arrays.asList(
            "", // 0
            "Hangup", // 1
            "Interrupt", // 2
            "Quit", // 3
            "Illegal instruction", // 4
            "Trace/breakpoint trap", // 5
            "Aborted", // 6
            "Bus error", // 7
            "Floating point exception", // 8
            "Killed", // 9
            "User defined signal 1", // 10
            "Segmentation fault", // 11
            "User defined signal 2", // 12
            "Broken pipe", // 13
            "Alarm clock", // 14
            "Terminated", // 15
            "Stack fault", // 16
            "Child exited", // 17
            "Continued", // 18
            "Stopped (signal)", // 19
            "Stopped", // 20
            "Stopped (tty input)", // 21
            "Stopped (tty output)", // 22
            "Urgent I/O condition", // 23
            "CPU time limit exceeded", // 24
            "File size limit exceeded", // 25
            "Virtual timer expired", // 26
            "Profiling timer expired", // 27
            "Window changed", // 28
            "I/O possible", // 29
            "Power failure", // 30
            "Bad system call" // 31
    );

    public static void delFile(String fileId) {
        try {
            restTemplate.delete(SANDBOX_BASE_URL + "/file/{0}", fileId);
        } catch (RestClientResponseException exception) {
            if(exception.getRawStatusCode() != 200) {
                log.error("安全沙箱判题的删除内存中的文件缓存操作异常----------------->{}", exception.getResponseBodyAsString());
            }
        }
    }

    public JSONArray run(String uri, JSONObject param) throws SystemError {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> request = new HttpEntity<>(JSONUtil.toJsonStr(param), headers);
        ResponseEntity<String> postForEntity;

        try {
            postForEntity = restTemplate.postForEntity(SANDBOX_BASE_URL + uri, request, String.class);
            return JSONUtil.parseArray(postForEntity.getBody());
        } catch (RestClientResponseException exception) {
            if(exception.getRawStatusCode() != 200) {
                throw  new SystemError("Cannot connect to sandbox service.", null, exception.getResponseBodyAsString());
            }
        } catch (Exception exception) {
            throw new SystemError("Call SandBox Error.", null, exception.getMessage());
        }
        return null;
    }

    /**
     *
     * @param maxCpuTime        最大编译的cpu时间 ms
     * @param maxRealTime       最大编译的真实时间 ms
     * @param maxMemory         最大编译的空间 b
     * @param maxStack          最大编译的栈空间 b
     * @param srcName           编译的源文件名字
     * @param exeName           编译生成的exe文件名字
     * @param args              编译的cmd参数
     * @param envs              编译的环境变量
     * @param code              编译的源代码
     * @param extraFiles        编译所需的额外文件 key:文件名，value:文件内容
     * @param needCopyOutCached 是否需要生成用户程序的缓存文件，即生成用户程序id
     * @param needCopyOutExe    是否需要生成编译后的用户程序exe文件
     * @param copyOutDir        生成编译后的用户程序exe文件的指定路径
     * @return
     */
    public static JSONArray compile(Long maxCpuTime,
                                    Long maxRealTime,
                                    Long maxMemory,
                                    Long maxStack,
                                    String srcName,
                                    String exeName,
                                    List<String> args,
                                    List<String> envs,
                                    String code,
                                    HashMap<String,String> extraFiles,
                                    Boolean needCopyOutCached,
                                    Boolean needCopyOutExe,
                                    String copyOutDir) throws SystemError {

        JSONObject cmd = new JSONObject();
        cmd.set("args", args);
        cmd.set("env",envs);
        cmd.set("files", COMPILE_FILES);

        // ms --> ns
        cmd.set("cpuLimit", maxCpuTime * 1000 * 1000L);
        cmd.set("clockLimit", maxRealTime * 1000 * 1000L);

        // byte
        cmd.set("memoryLimit", maxMemory);
        cmd.set("procLimit", maxProcessNumber);
        cmd.set("stackLimit", maxStack);

        JSONObject fileContent = new JSONObject();
        fileContent.set("content", code);

        JSONObject copyIn = new JSONObject();
        copyIn.set(srcName, fileContent);

        if(extraFiles != null) {
            for(Map.Entry<String,String> entry: extraFiles.entrySet()) {
                if(!StringUtils.isEmpty(entry.getKey()) && !StringUtils.isEmpty(entry.getValue())) {
                    JSONObject content = new JSONObject();
                    content.set("content", entry.getValue());
                    copyIn.set(entry.getKey(), entry.getValue());
                }
            }
        }

        cmd.set("copyIn", copyIn);
        cmd.set("copyOut", new JSONArray().put("stdout").put("stderr"));

        if(needCopyOutCached) {
            cmd.set("copyOutCached", new JSONArray().put(exeName));
        }

        if(needCopyOutExe) {
            cmd.set("copyOutDir", copyOutDir);
        }

        JSONObject param = new JSONObject();
        param.set("cmd", new JSONArray().put(cmd));

        JSONArray result = instance.run("/run", param);
        JSONObject compileRes = (JSONObject) result.get(0);
        compileRes.set("originalStatus", compileRes.getStr("status"));
        compileRes.set("status", RESULT_MAP_STATUS.get(compileRes.getStr("status")));
        return result;
    }

    /**
     * "files": [{
     * "content": ""
     * }, {
     * "name": "stdout",
     * "max": 1024 * 1024 * 32
     * }, {
     * "name": "stderr",
     * "max": 1024 * 1024 * 32
     * }]
     */

    private static final JSONArray COMPILE_FILES = new JSONArray();

    static {
        JSONObject content = new JSONObject();
        content.set("content", "");

        JSONObject stdout = new JSONObject();
        stdout.set("name", "stdout");
        stdout.set("max", 1024 * 1024 *STDIO_SIZE_MB);

        JSONObject stderr = new JSONObject();
        stderr.set("name", "stderr");
        stderr.set("max", 1024 * 1024 * STDIO_SIZE_MB);
        COMPILE_FILES.put(content);
        COMPILE_FILES.put(stdout);
        COMPILE_FILES.put(stderr);
    }

    /**
     *
     * @param args            普通评测运行cmd的命令参数
     * @param envs            普通评测运行的环境变量
     * @param testCasePath    题目数据的输入文件路径
     * @param testCaseContent 题目数据的输入数据（与testCasePath二者选一）
     * @param maxTime         评测的最大限制时间 ms
     * @param maxOutputSize   评测的最大输出大小 kb
     * @param maxStack        评测的最大限制栈空间 mb
     * @param exeName         评测的用户程序名称
     * @param fileId          评测的用户程序文件id
     * @param fileContent     评测的用户程序文件内容，如果userFileId存在则为null
     *
     * @Description 普通评测
     * @return
     * @throws SystemError
     */
    public static JSONArray testCase(List<String> args,
                                     List<String> envs,
                                     String testCasePath,
                                     String testCaseContent,
                                     Long maxTime,
                                     Long maxMemory,
                                     Long maxOutputSize,
                                     Integer maxStack,
                                     String exeName,
                                     String fileId,
                                     String fileContent) throws SystemError {
        JSONObject cmd = new JSONObject();
        cmd.set("args", args);
        cmd.set("env", envs);

        JSONArray files = new JSONArray();
        JSONObject content = new JSONObject();

        if(StringUtils.isEmpty(testCasePath)) {
            content.set("content", testCaseContent);
        } else {
            content.set("src", testCasePath);
        }

        JSONObject stdout = new JSONObject();
        stdout.set("name", "stdout");
        stdout.set("max", maxOutputSize);

        JSONObject stderr = new JSONObject();
        stderr.set("name", "stderr");
        stderr.set("max", 1024 * 1024 * 16);

        files.put(content);
        files.put(stdout);
        files.put(stderr);

        cmd.set("files", files);

        // ms -> ns
        cmd.set("cpuLimit", maxTime * 1000 * 1000L);
        cmd.set("clockLimit", maxTime * 1000 * 1000L * 3);
        // byte
        cmd.set("memoryLimit", (maxMemory + 100) * 1024 * 1024L);
        cmd.set("procLimit", maxProcessNumber);
        cmd.set("stackLimit", maxStack * 1024 * 1024L);

        JSONObject exeFile = new JSONObject();
        if(!StringUtils.isEmpty(fileId)) {
            exeFile.set("fileId", fileId);
        } else {
            exeFile.set("content", fileContent);
        }

        JSONObject copyIn = new JSONObject();
        copyIn.set(exeName, exeFile);

        cmd.set("copyIn", copyIn);
        cmd.set("copyOut", new JSONArray().put("stdout").put("stderr"));

        JSONObject param = new JSONObject();
        param.set("cmd", new JSONArray().put(cmd));

        // 调用判题安全沙箱
        JSONArray result = instance.run("/run", param);

        JSONObject testcaseRes = (JSONObject) result.get(0);
        testcaseRes.set("originalStatus", testcaseRes.getStr("status"));
        testcaseRes.set("status",  RESULT_MAP_STATUS.get(testcaseRes.getStr("status")));

        return result;
    }

    public static JSONArray spjCheckResult(List<String> args,
                                           List<String> envs,
                                           String userOutputFilePath,
                                           String userOutputFileName,
                                           String testCaseInputFilePath,
                                           String testCaseInputFileName,
                                           String testCaseOutputFilePath,
                                           String testCaseOutputFileName,
                                           String spjExeSrc,
                                           String spjExeName) throws SystemError {

        JSONObject cmd = new JSONObject();
        cmd.set("args", args);
        cmd.set("env", envs);

        JSONArray outFiles = new JSONArray();

        JSONObject content  = new JSONObject();
        content.set("content","");

        JSONObject outStdout = new JSONObject();
        outStdout.set("name", "stdout");
        outStdout.set("max", 1024 * 1024 * 16);

        JSONObject outStderr = new JSONObject();
        outStderr.set("name", "stderr");
        outStderr.set("max", 1024 * 1024 * 16);

        outFiles.put(content);
        outFiles.put(outStdout);
        outFiles.put(outStderr);

        // ms-->ns
        cmd.set("cpuLimit", TIME_LIMIT_MS * 1000 * 1000L);
        cmd.set("clockLimit", TIME_LIMIT_MS * 1000 * 1000L * 3);
        // byte
        cmd.set("memoryLimit", MEMORY_LIMIT_MB * 1024 * 1024L);
        cmd.set("procLimit", maxProcessNumber);
        cmd.set("stackLimit", STACK_LIMIT_MB * 1024 * 1024L);

        JSONObject spjExeFile = new JSONObject();
        spjExeFile.set("src", spjExeSrc);

        JSONObject userOutputFileSrc = new JSONObject();
        userOutputFileSrc.set("src", userOutputFilePath);

        JSONObject stdInputFileSrc = new JSONObject();
        stdInputFileSrc.set("src", testCaseInputFilePath);

        JSONObject stdOutFileSrc = new JSONObject();
        stdOutFileSrc.set("src", testCaseOutputFilePath);

        JSONObject spjCopyIn = new JSONObject();

        spjCopyIn.set(spjExeName, spjExeFile);
        spjCopyIn.set(userOutputFileName, userOutputFileSrc);
        spjCopyIn.set(testCaseInputFileName, stdInputFileSrc);
        spjCopyIn.set(testCaseOutputFileName, stdOutFileSrc);

        cmd.set("copyIn", spjCopyIn);
        cmd.set("copyOut", new JSONArray().put("stdout").put("stderr"));

        JSONObject param = new JSONObject();
        param.set("cmd", new JSONArray().put(cmd));

        // 调用判题安全沙箱
        JSONArray result = instance.run("run", param);
        JSONObject spjRes = (JSONObject) result.get(0);
        spjRes.set("originalStatus", spjRes.getStr("status"));
        spjRes.set("status", RESULT_MAP_STATUS.get(spjRes.getStr("status")));
        return  result;
    }

    public static JSONArray interactiveTestCase(List<String> args,
                                                List<String> envs,
                                                String userExeName,
                                                String userFileId,
                                                String userFileContent,
                                                Long userMaxTime,
                                                Long userMaxMemory,
                                                Integer userMaxStack,
                                                String testCaseInputPath,
                                                String testCaseInputFileName,
                                                String testCaseOutputFilePath,
                                                String testCaseOutputFileName,
                                                String userOutputFileName,
                                                List<String> interactArgs,
                                                List<String> interactEnvs,
                                                String interactExeSrc,
                                                String interactExeName) throws SystemError {
        /**
         *  注意：用户源代码需要先编译，若是通过编译需要先将文件存入内存，再利用管道判题，同时特殊判题程序必须已编译且存在（否则判题失败，系统错误）！
         */

        JSONObject pipeInputCmd = new JSONObject();
        pipeInputCmd.set("args", args);
        pipeInputCmd.set("env", envs);

        JSONArray files = new JSONArray();
        JSONObject stderr = new JSONObject();
        stderr.set("name", "stderr");
        stderr.set("max", 1024 * 1024 * STDIO_SIZE_MB);

        files.put(new JSONObject());
        files.put(new JSONObject());
        files.put(stderr);

        String inTmp = files.toString().replace("{}", "null");
        pipeInputCmd.set("files", JSONUtil.parseArray(inTmp, false));

        // ms-->ns
        pipeInputCmd.set("cpuLimit", userMaxTime * 1000 * 1000L);
        pipeInputCmd.set("clockLimit", userMaxTime * 1000 * 1000L * 3);

        // byte
        pipeInputCmd.set("memoryLimit", (userMaxMemory + 100) * 1024 * 1024L);
        pipeInputCmd.set("procLimit", maxProcessNumber);
        pipeInputCmd.set("stackLimit", userMaxStack * 1024 * 1024L);

        JSONObject exeFile = new JSONObject();
        if(!StringUtils.isEmpty(userFileId)) {
            exeFile.set("fileId", userFileId);
        } else {
            exeFile.set("content", userFileContent);
        }
        JSONObject copyIn = new JSONObject();
        copyIn.set(userExeName, exeFile);

        pipeInputCmd.set("copyIn", copyIn);
        pipeInputCmd.set("copyOut", new JSONObject());

        // 管道输出，用户程序输出数据经过特殊判题程序后，得到的最终输出结果。
        JSONObject pipeOutputCmd = new JSONObject();
        pipeOutputCmd.set("args", interactArgs);
        pipeOutputCmd.set("env", interactEnvs);

        JSONArray outFiles = new JSONArray();

        JSONObject outStderr = new JSONObject();
        outStderr.set("name", "stderr");
        outStderr.set("max", 1024 * 1024 * STDIO_SIZE_MB);
        outFiles.put(new JSONObject());
        outFiles.put(new JSONObject());
        outFiles.put(outStderr);
        String outTmp = outFiles.toString().replace("{}", "null");
        pipeOutputCmd.set("files", JSONUtil.parseArray(outTmp, false));

        // ms-->ns
        pipeOutputCmd.set("cpuLimit", userMaxTime * 1000 * 1000L * 2);
        pipeOutputCmd.set("clockLimit", userMaxTime * 1000 * 1000L * 3 * 2);
        // byte
        pipeOutputCmd.set("memoryLimit", (userMaxMemory + 100) * 1024 * 1024L * 2);
        pipeOutputCmd.set("procLimit", maxProcessNumber);
        pipeOutputCmd.set("stackLimit", STACK_LIMIT_MB * 1024 * 1024L);

        JSONObject spjExeFile = new JSONObject();
        spjExeFile.set("src", interactExeSrc);

        JSONObject stdInputFileSrc = new JSONObject();
        stdInputFileSrc.set("src", testCaseInputPath);

        JSONObject stdOutFileSrc = new JSONObject();
        stdOutFileSrc.set("src", testCaseOutputFilePath);

        JSONObject interactiveCopyIn = new JSONObject();
        interactiveCopyIn.set(interactExeName, spjExeFile);
        interactiveCopyIn.set(testCaseInputFileName, stdInputFileSrc);
        interactiveCopyIn.set(testCaseOutputFileName, stdOutFileSrc);

        pipeInputCmd.set("copyIn", interactiveCopyIn);
        pipeInputCmd.set("copyOut", new JSONArray().put(userOutputFileName));

        JSONArray cmdList = new JSONArray();
        cmdList.put(pipeInputCmd);
        cmdList.put(pipeOutputCmd);

        JSONObject param = new JSONObject();
        // 添加cmd指令
        param.set("cmd", cmdList);

        JSONArray pipeMapping = new JSONArray();
        // 用户程序
        JSONObject user = new JSONObject();

        JSONObject userIn = new JSONObject();
        userIn.set("index", 0);
        userIn.set("fd", 1);

        JSONObject userOut = new JSONObject();
        userOut.set("index", 1);
        userOut.set("fd", 0);

        user.set("in", userIn);
        user.set("out", userOut);
        user.set("max", STDIO_SIZE_MB * 1024 * 1024L);
        user.set("proxy", true);
        user.set("name", "stdout");

        // 评测程序
        JSONObject judge = new JSONObject();

        JSONObject judgeIn = new JSONObject();
        judgeIn.set("index", 1);
        judgeIn.set("fd", 1);

        JSONObject judgeOut = new JSONObject();
        judgeOut.set("index", 0);
        judgeOut.set("fd", 0);

        judge.set("in", judgeIn);
        judge.set("out", judgeOut);
        judge.set("max", STDIO_SIZE_MB * 1024 * 1024);
        judge.set("proxy", true);
        judge.set("name", "stdout");

        // 添加到管道映射列表
        pipeMapping.add(user);
        pipeMapping.add(judge);

        param.set("pipeMapping", pipeMapping);

        // 调用判题安全沙箱
        JSONArray result = instance.run("/run", param);
        JSONObject userRes = (JSONObject) result.get(0);
        JSONObject interactiveRes = (JSONObject) result.get(1);
        userRes.set("originalStatus", userRes.getStr("status"));
        userRes.set("status", RESULT_MAP_STATUS.get(userRes.getStr("status")));
        interactiveRes.set("originalStatus", interactiveRes.getStr("status"));
        interactiveRes.set("status", RESULT_MAP_STATUS.get(interactiveRes.getStr("status")));
        return result;
    }
}
