package com.github.loj.judge;

import cn.hutool.json.JSON;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.github.loj.common.exception.SystemError;
import com.github.loj.judge.entity.JudgeDTO;
import com.github.loj.judge.entity.JudgeGlobalDTO;
import com.github.loj.judge.entity.LanguageConfig;
import com.github.loj.judge.tesk.*;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.util.Constants;
import com.github.loj.util.JudgeUtils;
import com.github.loj.util.ThreadPoolUtils;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.File;
import java.util.*;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

/**
 * @author lxhcaicai
 * @date 2023/4/15 16:51
 * @Description 该类负责输入数据进入程序进行测评
 */
@Component
public class JudgeRun {

    @Resource
    private DefaultJudge defaultJudge;

    @Resource
    private SpecialJudge specialJudge;

    @Resource
    private InteractiveJudge interactiveJudge;


    @Resource
    private TestJudge testJudge;

    @Resource
    private LanguageConfigLoader languageConfigLoader;

    public TestJudgeRes testJudgeCase(String userFileId, TestJudgeReq testJudgeReq) throws ExecutionException, InterruptedException {

        // 默认给限制时间+200ms用来测评
        Long testTime = testJudgeReq.getTimeLimit() + 200L;

        LanguageConfig runConfig = languageConfigLoader.getLanguageConfigByName(testJudgeReq.getLanguage());

        JudgeGlobalDTO judgeGlobalDTO = JudgeGlobalDTO.builder()
                .judgeMode(Constants.JudgeMode.TEST)
                .userFileId(userFileId)
                .userFileContent(testJudgeReq.getCode())
                .testTime(testTime)
                .maxMemory((long)testJudgeReq.getMemoryLimit())
                .maxTime((long)testJudgeReq.getTimeLimit())
                .maxStack(testJudgeReq.getStackLimit())
                .removeEOLBlank(testJudgeReq.getIsRemoveEndBlank())
                .runConfig(runConfig)
                .build();

        Long maxOutputSize = Math.max(testJudgeReq.getTestCaseInput().length() * 2L, 32 * 1024 * 1024L);

        JudgeDTO judgeDTO = JudgeDTO.builder()
                .testCaseInputContent(testJudgeReq.getTestCaseInput() + "\n")
                .maxOutputSize(maxOutputSize)
                .testCaseOutputContent(testJudgeReq.getExpectedOutput())
                .build();

        FutureTask<JSONObject> testJudgeFutureTask = new FutureTask<>(() -> testJudge.judge(judgeDTO,judgeGlobalDTO));

        JSONObject judgeRes = SubmitTask2ThreadPool(testJudgeFutureTask);

        return TestJudgeRes.builder()
                .status(judgeRes.getInt("status"))
                .memory(judgeRes.getLong("memory"))
                .time(judgeRes.getLong("time"))
                .stdout(judgeRes.getStr("output"))
                .stderr(judgeRes.getStr("errMsg"))
                .build();
    }

    private JSONObject SubmitTask2ThreadPool(FutureTask<JSONObject> futureTask) throws ExecutionException, InterruptedException {
        // 提交到线程池进行执行
        ThreadPoolUtils.getInstance().getThreadPool().submit(futureTask);

        while (true) {
            if(futureTask.isDone() && !futureTask.isCancelled()) {
                // 获取线程返回结果
                return futureTask.get();
            } else {
                Thread.sleep(10); // 避免CPU高速运转
            }
        }
    }

    private List<JSONObject> SubmitBatchTask2ThreadPool(List<FutureTask<JSONObject>> futureTasks) throws ExecutionException, InterruptedException {
        for(FutureTask<JSONObject> futureTask: futureTasks) {
            ThreadPoolUtils.getInstance().getThreadPool().submit(futureTask);
        }
        List<JSONObject> result = new LinkedList<>();
        while(futureTasks.size() > 0) {
            Iterator<FutureTask<JSONObject>> iterable = futureTasks.iterator();

            while (iterable.hasNext()) {
                FutureTask<JSONObject> future = iterable.next();
                if(future.isDone() && !future.isCancelled()) {
                    Object obj = future.get();
                    JSONObject tmp = (JSONObject) obj;
                    result.add(tmp);
                    // 任务完成移除任务
                    iterable.remove();
                } else {
                    Thread.sleep(10);
                }
            }
        }
        return  result;
    }

    public List<JSONObject> judgeAllCase(Long submitId,
                                         Problem problem,
                                         String judgeLanguage,
                                         String testCaseDir,
                                         JSONObject testCasesInfo,
                                         String userFileId,
                                         String userFileContent,
                                         Boolean getUserOutput,
                                         String judgeCaseMode) throws SystemError, ExecutionException, InterruptedException {
        if(testCasesInfo == null) {
            throw new SystemError("The evalution data of problem does not exist", null, null);
        }
        JSONArray testCaseList = (JSONArray) testCasesInfo.get("testCases");

        // 默认题目的限制的时间 + 200ms
        Long testTime = (long)problem.getTimeLimit() + 200;

        Constants.JudgeMode judgeMode = Constants.JudgeMode.getJudgeMode(problem.getJudgeMode());

        if(judgeMode == null) {
            throw  new RuntimeException("The judge mode of problem " + problem.getProblemId() + "error:" + problem.getJudgeMode());
        }

        // 用户输出的文件夹
        String runDir = Constants.JudgeDir.RUN_WORKPLACE_DIR.getContent() + "/" + submitId;

        LanguageConfig runConfig = languageConfigLoader.getLanguageConfigByName(judgeLanguage);
        LanguageConfig spjConfig = languageConfigLoader.getLanguageConfigByName("SPJ-" + problem.getSpjLanguage());
        LanguageConfig interactiveConfig = languageConfigLoader.getLanguageConfigByName("INTERACTIVE-" + problem.getSpjLanguage());

        final AbstractJudge abstractJudge = getAbstarct(judgeMode);

        JudgeGlobalDTO judgeGlobalDTO = JudgeGlobalDTO.builder()
                .problemId(problem.getId())
                .judgeMode(judgeMode)
                .userFileId(userFileId)
                .userFileContent(userFileContent)
                .runDir(runDir)
                .testTime(testTime)
                .maxMemory((long)problem.getMemoryLimit())
                .maxTime((long)problem.getTimeLimit())
                .maxStack(problem.getStackLimit())
                .testCaseInfo(testCasesInfo)
                .judgeExtraFiles(JudgeUtils.getProblemExtraFileMap(problem, "judge"))
                .runConfig(runConfig)
                .spjRunConfig(spjConfig)
                .interactiveRunConfig(interactiveConfig)
                .needUserOutPutFile(getUserOutput)
                .removeEOLBlank(problem.getIsRemoveEndBlank())
                .build();

        // OI 题目的substack最低分模式,则每个substack组最要有一个case没有AC 或者 percentage 为 0 则剩下的评测点跳过I，不再评测
        if(Constants.Contest.TYPE_OI.getCode().equals(problem.getType())
                && Constants.JudgeCaseMode.SUBTASK_LOWEST.getMode().equals(judgeCaseMode)) {
            return substackJudgeAllCase(testCaseList, testCaseDir, judgeGlobalDTO, abstractJudge);
        } else if(Constants.JudgeCaseMode.ERGODIC_WITHOUT_ERROR.getMode().equals(judgeCaseMode)) {
            // 顺序评测测试点, 遇到非AC的就停止
            return ergodicJudgeAllCase(testCaseList,testCaseDir, judgeGlobalDTO, abstractJudge);
        } else {
            // 默认全部测试点都评测
            return defaultJudgeAllCase(testCaseList, testCaseDir, judgeGlobalDTO, abstractJudge);
        }
    }

    private AbstractJudge getAbstarct(Constants.JudgeMode judgeMode) {
        switch (judgeMode) {
            case DEFAULT:
                return defaultJudge;
            case SPJ:
                return specialJudge;
            case INTERACTIVE:
                return interactiveJudge;
            default:
                throw new RuntimeException("The problem judge mode is error:" + judgeMode);
        }
    }

    /**
     * 异步线程处理 默认评测
     * @param testCaseList
     * @param testCaseDir
     * @param judgeGlobalDTO
     * @param abstractJudge
     * @return
     */
    private List<JSONObject> defaultJudgeAllCase(JSONArray testCaseList,
                                                 String testCaseDir,
                                                 JudgeGlobalDTO judgeGlobalDTO,
                                                 AbstractJudge abstractJudge) throws ExecutionException, InterruptedException {

        List<FutureTask<JSONObject>> futureTasks = new ArrayList<>();
        for(int index = 0; index < testCaseList.size(); index ++) {
            JSONObject testCase = (JSONObject) testCaseList.get(index);
            // 将每个需要测试线程任务加入任务队列中
            final int testCaseId = index + 1;
            // 输入文件名
            final String inputFileName = testCase.getStr("inputName");
            // 输出文件名
            final String outFileName = testCase.getStr("outputName");
            // 题目数据的输入文件路径
            final String testCaseInputPath = testCaseDir + "/" + inputFileName;
            // 题目数据的输出文件路径
            final String testCaseOutputPath = testCaseDir + "/" + outFileName;
            // 数据库的测试样例ID
            final Long caseId = testCase.getLong("caseId", null);
            // 该测试点分数
            final Integer score = testCase.getInt("score", 0);
            // 该测试点分组 (用于subtask)
            final Integer groupNum = testCase.getInt("groupNum", 1);

            final Long maxOutputSize = Math.max(testCase.getLong("outputSize", 0L) * 2 , 32 * 1024 * 1024L);

            JudgeDTO judgeDTO = JudgeDTO.builder()
                    .testCaseNum(testCaseId)
                    .testCaseInputFileName(inputFileName)
                    .testCaseInputPath(testCaseInputPath)
                    .testCaseOutputFileName(outFileName)
                    .testCaseOutputPath(testCaseOutputPath)
                    .maxOutputSize(maxOutputSize)
                    .score(score)
                    .build();

            futureTasks.add(new FutureTask<>(() -> {
                JSONObject result = abstractJudge.judge(judgeDTO, judgeGlobalDTO);
                result.set("caseId", caseId);
                result.set("score", judgeDTO.getScore());
                result.set("inputFileName", judgeDTO.getTestCaseInputFileName());
                result.set("outputFileName", judgeDTO.getTestCaseInputFileName());
                result.set("groupName", groupNum);
                result.set("seq", testCaseId);
                return result;
            }));

        }
        return SubmitBatchTask2ThreadPool(futureTasks);
    }

    private List<JSONObject> ergodicJudgeAllCase(JSONArray testCaseList,
                                                 String testCaseDir,
                                                 JudgeGlobalDTO judgeGlobalDTO,
                                                 AbstractJudge abstractJudge) throws ExecutionException, InterruptedException {

        List<JSONObject> judgeResList = new ArrayList<>();
        for(int index = 0; index < testCaseList.size(); index ++) {
            JSONObject testCase = (JSONObject) testCaseList.get(index);
            // 将每个需要测试线程任务加入任务队列中
            final int testCaseId = index + 1;
            // 输入文件名
            final String inputFileName = testCase.getStr("inputName");
            // 输出文件名
            final String outFileName = testCase.getStr("outputName");
            // 题目数据的输入文件路径
            final String testCaseInputPath = testCaseDir + "/" + inputFileName;
            // 题目数据的输出文件路径
            final String testCaseOutputPath = testCaseDir + "/" + outFileName;
            // 数据库的测试样例ID
            final Long caseId = testCase.getLong("caseId", null);
            // 该测试点分数
            final Integer score = testCase.getInt("score", 0);
            // 该测试点分组 (用于subtask)
            final Integer groupNum = testCase.getInt("groupNum", 1);

            final Long maxOutputSize = Math.max(testCase.getLong("outputSize", 0L) * 2, 32 * 1024 * 1024L);

            JudgeDTO judgeDTO = JudgeDTO.builder()
                    .testCaseNum(testCaseId)
                    .testCaseInputFileName(inputFileName)
                    .testCaseInputPath(testCaseInputPath)
                    .testCaseOutputFileName(outFileName)
                    .testCaseOutputPath(testCaseOutputPath)
                    .maxOutputSize(maxOutputSize)
                    .score(score)
                    .build();

            JSONObject judgeRes = SubmitTask2ThreadPool(new FutureTask<>(()->{
                JSONObject result = abstractJudge.judge(judgeDTO, judgeGlobalDTO);
                result.set("caseId", caseId);
                result.set("score", judgeDTO.getScore());
                result.set("inputFileName", judgeDTO.getTestCaseInputFileName());
                result.set("outputFileName", judgeDTO.getTestCaseInputFileName());
                result.set("groupName", groupNum);
                result.set("seq", testCaseId);
                return result;
            }));
            judgeResList.add(judgeRes);
            Integer status = judgeRes.getInt("status");
            if(!Constants.Judge.STATUS_ACCEPTED.getStatus().equals(status)) {
                break;
            }
        }
        return judgeResList;
    }

    private List<JSONObject> substackJudgeAllCase(JSONArray testCaseList,
                                                 String testCaseDir,
                                                 JudgeGlobalDTO judgeGlobalDTO,
                                                 AbstractJudge abstractJudge) throws ExecutionException, InterruptedException {
        Map<Integer, List<JudgeDTO>> judgeDTOMap = new LinkedHashMap<>();
        for(int index = 0; index < testCaseList.size(); index ++) {
            JSONObject testCase = (JSONObject) testCaseList.get(index);
            // 将每个需要测试线程任务加入任务队列中
            final int testCaseId = index + 1;
            // 输入文件名
            final String inputFileName = testCase.getStr("inputName");
            // 输出文件名
            final String outFileName = testCase.getStr("outputName");
            // 题目数据的输入文件路径
            final String testCaseInputPath = testCaseDir + "/" + inputFileName;
            // 题目数据的输出文件路径
            final String testCaseOutputPath = testCaseDir + "/" + outFileName;
            // 数据库的测试样例ID
            final Long caseId = testCase.getLong("caseId", null);
            // 该测试点分数
            final Integer score = testCase.getInt("score", 0);
            // 该测试点分组 (用于subtask)
            final Integer groupNum = testCase.getInt("groupNum", 1);

            final Long maxOutputSize = Math.max(testCase.getLong("outputSize", 0L) * 2, 32 * 1024 * 1024L);

            JudgeDTO judgeDTO = JudgeDTO.builder()
                    .testCaseNum(testCaseId)
                    .testCaseInputFileName(inputFileName)
                    .testCaseInputPath(testCaseInputPath)
                    .testCaseOutputFileName(outFileName)
                    .testCaseOutputPath(testCaseOutputPath)
                    .maxOutputSize(maxOutputSize)
                    .score(score)
                    .build();

            List<JudgeDTO> judgeDTOList = judgeDTOMap.get(groupNum);
            if(judgeDTOList == null) {
                judgeDTOList = new ArrayList<>();
                judgeDTOList.add(judgeDTO);
                judgeDTOMap.put(groupNum, judgeDTOList);
            } else {
                judgeDTOList.add(judgeDTO);
            }
        }
        List<JSONObject> judgeResList = new ArrayList<>();
        for(Map.Entry<Integer, List<JudgeDTO>> entry: judgeDTOMap.entrySet()) {
            Integer groupNum = entry.getKey();
            Iterator<JudgeDTO> iterator = entry.getValue().iterator();
            while(iterator.hasNext()) {
                JudgeDTO judgeDTO = iterator.next();
                JSONObject judgeRes = SubmitTask2ThreadPool(new FutureTask<>(() -> {
                    JSONObject result = abstractJudge.judge(judgeDTO, judgeGlobalDTO);
                    result.set("caseId", judgeDTO.getProblemCaseId());
                    result.set("score", judgeDTO.getScore());
                    result.set("inputFileName", judgeDTO.getTestCaseInputFileName());
                    result.set("outputFileName", judgeDTO.getTestCaseInputFileName());
                    result.set("groupName", groupNum);
                    result.set("seq", judgeDTO.getTestCaseNum());
                    return result;
                }));
                judgeResList.add(judgeRes);
                Integer status = judgeRes.getInt("status");
                Double percentage = judgeRes.getDouble("percentage");
                if(!Constants.Judge.STATUS_ACCEPTED.getStatus().equals(status)
                        && !(Constants.Judge.STATUS_PARTIAL_ACCEPTED.getStatus().equals(status)
                        && percentage != null && percentage > 0.0)) {

                    // 有评测点得分为0分，不再评测该组其他测试点
                    while(iterator.hasNext()) {
                        JudgeDTO elseJudgeDTO = iterator.next();
                        JSONObject elseJudgeRes = new JSONObject();
                        elseJudgeRes.set("status", Constants.Judge.STATUS_CANCELLED.getStatus());
                        elseJudgeRes.set("memory", 0);
                        elseJudgeRes.set("time", 0);
                        elseJudgeRes.set("errMsg", "Cancelled: Skipped Judging");
                        elseJudgeRes.set("caseId", elseJudgeDTO.getProblemCaseId());
                        elseJudgeRes.set("score", elseJudgeDTO.getScore());
                        elseJudgeRes.set("inputFileName", elseJudgeDTO.getTestCaseInputFileName());
                        elseJudgeRes.set("outputFileName", elseJudgeDTO.getTestCaseOutputFileName());
                        elseJudgeRes.set("groupNum", groupNum);
                        elseJudgeRes.set("seq", judgeDTO.getTestCaseNum());
                        judgeResList.add(elseJudgeRes);
                    }
                    break;
                }
            }
        }
        return judgeResList;
    }
}
