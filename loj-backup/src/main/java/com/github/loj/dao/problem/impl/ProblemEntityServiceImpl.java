package com.github.loj.dao.problem.impl;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.file.FileReader;
import cn.hutool.core.io.file.FileWriter;
import cn.hutool.core.lang.UUID;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.*;
import com.github.loj.exception.ProblemIDRepeatException;
import com.github.loj.mapper.ProblemMapper;
import com.github.loj.pojo.bo.Pair_;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.problem.*;
import com.github.loj.pojo.vo.ProblemCountVO;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.utils.Constants;
import io.netty.util.CharsetUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/7 0:32
 */
@Service
public class ProblemEntityServiceImpl extends ServiceImpl<ProblemMapper, Problem> implements ProblemEntityService {

    @Autowired
    private ProblemMapper problemMapper;

    @Autowired
    private JudgeEntityService judgeEntityService;

    @Autowired
    private ProblemLanguageEntityService problemLanguageEntityService;

    @Autowired
    private CodeTemplateEntityService codeTemplateEntityService;

    @Autowired
    private ProblemCaseEntityService problemCaseEntityService;

    @Autowired
    private ProblemTagEntityService problemTagEntityService;

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    private TagEntityService tagEntityService;

    private final static Pattern EOL_PATTERN = Pattern.compile("[^\\S\\n]+(?=\\n)");

    @Override
    public Page<ProblemVO> getProblemList(int limit, int currentPage, Long pid, String title, Integer difficulty, List<Long> tid, String oj) {

        // 新建分页
        Page<ProblemVO> page = new Page<>(currentPage, limit);
        Integer tagListSize = null;
        if(tid != null) {
            tid = tid.stream().distinct().collect(Collectors.toList());;
            tagListSize = tid.size();
        }

        List<ProblemVO> problemList = problemMapper.getProblemList(page,pid, title, difficulty, tid, tagListSize, oj);

        if(problemList.size() > 0) {
            List<Long> pidList = problemList.stream().map(ProblemVO::getPid).collect(Collectors.toList());
            List<ProblemCountVO> problemListCount = judgeEntityService.getProblemListCount(pidList);
            for(ProblemVO problemVO: problemList) {
                for(ProblemCountVO problemCountVO: problemListCount) {
                    if(problemVO.getPid().equals(problemCountVO.getPid())) {
                        problemVO.setProblemCountVo(problemCountVO);
                        break;
                    }
                }
            }
        }
        return page.setRecords(problemList);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean adminAddProblem(ProblemDTO problemDTO) {

        Problem problem = problemDTO.getProblem();

        if(Constants.JudgeMode.DEFAULT.getMode().equals(problemDTO.getJudgeMode())) {
            problem.setSpjLanguage(null)
                    .setSpjCode(null);
        }

        // 设置测试样例的版本号
        problem.setCaseVersion(String.valueOf(System.currentTimeMillis()));
        if(problem.getIsGroup() == null) {
            problem.setIsGroup(false);
        }

        // 如果没有提供problemId,则或者生成 P1000之类的，以problem表的id作为数字
        if(problem.getProblemId() == null) {
            problem.setProblemId(UUID.fastUUID().toString());
            problemMapper.insert(problem);

            UpdateWrapper<Problem> problemUpdateWrapper = new UpdateWrapper<>();
            problemUpdateWrapper.set("problem_id","P" + problem.getId());
            problemUpdateWrapper.eq("id",problem.getId());
            problemMapper.update(null,problemUpdateWrapper);
            problem.setProblemId("P" + problem.getId());
        } else {
            // problem_id唯一性检查
            String problemId = problem.getProblemId().toUpperCase();
            QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
            problemQueryWrapper.eq("problem_id", problemId);
            int existedProblem = problemMapper.selectCount(problemQueryWrapper);
            if(existedProblem > 0) {
                throw new ProblemIDRepeatException("The problem_id [" + problemId + "] already exists. Do not reuse it!");
            }
            problem.setProblemId(problemId);
            problemMapper.insert(problem);
        }

        Long pid = problem.getId();
        if(pid == null) {
            throw new ProblemIDRepeatException("The problem with problem_id [" + problem.getProblemId() + "] insert failed!");
        }
        // 为新的题目添加对应的language
        List<ProblemLanguage> problemLanguageList = new LinkedList<>();
        for(Language language: problemDTO.getLanguages()) {
            problemLanguageList.add(new ProblemLanguage().setPid(pid).setLid(language.getId()));
        }
        boolean addLangToProblemResult = problemLanguageEntityService.saveOrUpdateBatch(problemLanguageList);

        // 为新的题目添加对应的codeTemplate
        boolean addProblemCodeTemplate = true;
        if(problemDTO.getCodeTemplates() != null && problemDTO.getCodeTemplates().size() > 0) {
            for(CodeTemplate codeTemplate: problemDTO.getCodeTemplates()) {
                codeTemplate.setPid(pid);
            }
            addProblemCodeTemplate = codeTemplateEntityService.saveOrUpdateBatch(problemDTO.getCodeTemplates());
        }

        // 为新的题目添加对应的case
        boolean addCasesToProblemResult = true;
        if(problemDTO.getIsUploadTestCase()) { // 如果是选择上传测试文件的，则需要遍历对应文件夹，读取数据。。
            int sumScore = 0;
            String testCaseDir = problemDTO.getUploadTestcaseDir();;
            // 如果是io题目统计总分
            List<ProblemCase> problemCases = problemDTO.getSamples();
            if(problemCases.size() == 0) {
                throw new RuntimeException("The test cases of problem must not be empty!");
            }
            for(ProblemCase problemCase:problemCases) {
                if(problemCase.getScore() != null) {
                    sumScore += problemCase.getScore();
                }

                if(StringUtils.isEmpty(problemCase.getOutput())) {
                    String filePreName = problemCase.getInput().split("\\.")[0];
                    problemCase.setOutput(filePreName + ".out");
                }
                problemCase.setPid(pid);
            }
            // 设置oi总分数，根据每个测试点的加和
            if(problem.getType().intValue() == Constants.Contest.TYPE_OI.getCode()) {
                UpdateWrapper<Problem> problemUpdateWrapper = new UpdateWrapper<>();
                problemUpdateWrapper.eq("id", pid)
                        .set("id_secore", sumScore);
                problemMapper.update(null, problemUpdateWrapper);
            }
            addCasesToProblemResult = problemCaseEntityService.saveOrUpdateBatch(problemCases);
            // 获取代理bean对象执行异步方法===》根据测试文件初始info
            applicationContext.getBean(ProblemEntityServiceImpl.class)
                    .initUploadTestCase(
                            problemDTO.getJudgeMode(),
                            problem.getJudgeCaseMode(),
                            problem.getCaseVersion(),
                            pid,
                            testCaseDir,
                            problemDTO.getSamples());
        } else  {
            // oi题目需要求取平均值，给每个测试点初始oi的score值，默认总分100分
            if(problem.getType().intValue() == Constants.Contest.TYPE_OI.getCode()) {
                for(ProblemCase problemCase: problemDTO.getSamples()) {
                    // 设置好新题目的pid和累加总分数
                    problemCase.setPid(pid);
                }
                int sumScore = calProblemTotalScore(problem.getJudgeCaseMode(),problemDTO.getSamples());
                addCasesToProblemResult = problemCaseEntityService.saveOrUpdateBatch(problemDTO.getSamples());
                UpdateWrapper<Problem> problemUpdateWrapper = new UpdateWrapper<>();
                problemUpdateWrapper.eq("id", pid)
                        .set("io_score", sumScore);
                problemMapper.update(null, problemUpdateWrapper);
            } else {
                problemDTO.getSamples().forEach(problemCase -> problemCase.setPid(pid));
                addCasesToProblemResult = problemCaseEntityService.saveOrUpdateBatch(problemDTO.getSamples());
            }
            initHandTestCase(problemDTO.getJudgeMode(),
                    problem.getJudgeMode(),
                    problem.getCaseVersion(),
                    pid,
                    problemDTO.getSamples());
        }

        // 为新的题目添加对应的tag，可能tag是原表已有，也可能是新的，所以需要判断。
        List<ProblemTag> problemTagList = new LinkedList<>();
        if(problemDTO.getTags() != null) {
            for(Tag tag: problemDTO.getTags()) {
                if(tag.getId() == null) {  //id为空 表示为原tag表中不存在的 插入后可以获取到对应的tagId
                    Tag existedTag = tagEntityService.getOne(new QueryWrapper<Tag>().eq("name",tag.getName())
                            .eq("oj","ME"),false);
                    if(existedTag == null) {
                        tag.setOj("ME");
                        tagEntityService.save(tag);
                    } else {
                        tag = existedTag;
                    }
                }
                problemTagList.add(new ProblemTag().setTid(tag.getId()).setPid(pid));
            }
        }
        boolean addTagsToProblemResult = true;
        if(problemTagList.size() > 0) {
            addTagsToProblemResult = problemTagEntityService.saveOrUpdateBatch(problemTagList);
        }

        if(addCasesToProblemResult && addLangToProblemResult
                && addTagsToProblemResult && addProblemCodeTemplate) {
            return true;
        } else {
            return false;
        }
    }

    // 初始化上传文件的测试数据，写成json文件
    @Async
    public void initUploadTestCase(String judgeMode,
                                   String judgeCaseMode,
                                   String version,
                                   Long problemId,
                                   String tmpTestcaseDir,
                                   List<ProblemCase> problemCaseList) {
        String testCaseDir = Constants.File.TESTCASE_BASE_FOLDER.getPath() + File.separator + "problem_" + problemId;

        // 将之前的临时文件夹里面的评测文件全部复制到指定文件夹(覆盖)
        if(!StringUtils.isEmpty(tmpTestcaseDir)) {
            FileUtil.clean(testCaseDir);
            File testCaseDirFile = new File(testCaseDir);
            FileUtil.copyFilesFromDir(new File(tmpTestcaseDir), testCaseDirFile, true);
        }

        List<String> listFileNames = FileUtil.listFileNames(testCaseDir);

        if(StringUtils.isEmpty(judgeCaseMode)) {
            judgeCaseMode = Constants.JudgeCaseMode.DEFAULT.getMode();;
        }
        JSONObject result = new JSONObject();
        result.set("mode", judgeMode);
        result.set("judgeCaseMode", judgeCaseMode);
        result.set("version", version);
        result.set("testCasesSize", problemCaseList.size());

        JSONArray testCaseList = new JSONArray(problemCaseList.size());

        for(ProblemCase problemCase: problemCaseList) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.set("caseId", problemCase.getId());
            if(judgeCaseMode.equals(Constants.JudgeCaseMode.SUBTASK_AVERAGE.getMode())
                    || judgeCaseMode.equals(Constants.JudgeCaseMode.SUBTASK_LOWEST.getMode())) {
                jsonObject.set("groupNum", problemCase.getGroupNum());
            }

            jsonObject.set("score", problemCase.getScore());
            jsonObject.set("inputName", problemCase.getInput());
            jsonObject.set("outputName", problemCase.getOutput());

            listFileNames.remove(problemCase.getInput());
            listFileNames.remove(problemCase.getOutput());
            // 读取输入文件
            FileReader inputFile = new FileReader(testCaseDir + File.separator + problemCase.getInput(), CharsetUtil.UTF_8);
            String input = inputFile.readString()
                    .replaceAll("\r\n", "\n") // 避免window系统的换行问题
                    .replaceAll("\r", "\n");  // 避免mac系统的换行问题

            FileWriter inputFileWriter = new FileWriter(testCaseDir + File.separator + problemCase.getInput(), CharsetUtil.UTF_8);
            inputFileWriter.write(input);

            // 读取输出文件
            String output = "";
            String outputFilePath = testCaseDir + File.separator + problemCase.getOutput();
            if(FileUtil.exist(outputFilePath)) {
                FileReader outputFile = new FileReader(outputFilePath, CharsetUtil.UTF_8);
                output = outputFile.readString()
                        .replaceAll("\r\n", "\n") // 避免window系统的换行问题
                        .replaceAll("\r", "\n"); // 避免mac系统的换行问题
                FileWriter outFileWriter = new FileWriter(testCaseDir + File.separator + problemCase.getOutput(), CharsetUtil.UTF_8);
                outFileWriter.write(output);
            } else {
                FileWriter fileWriter = new FileWriter(outputFilePath);
                fileWriter.write("");
            }

            // spj和interactive是根据特判程序输出判断结果，所以无需初始化测试数据
            if(Constants.JudgeMode.DEFAULT.getMode().equals(judgeMode)) {
                // 原数据MD5
                jsonObject.set("outputMd5", DigestUtils.md5DigestAsHex(output.getBytes(StandardCharsets.UTF_8)));
                // 原数据大小
                jsonObject.set("outputSize", output.getBytes(StandardCharsets.UTF_8).length);
                // 去掉全部空格的MD5，用来判断pe
                jsonObject.set("allStrippedOutputMd5", DigestUtils.md5DigestAsHex(output.replaceAll("\\s+", "").getBytes(StandardCharsets.UTF_8)));
                // 默认去掉文末空格的MD5
                jsonObject.set("EOFStrippedOutputMd5",DigestUtils.md5DigestAsHex(rtrim(output).getBytes(StandardCharsets.UTF_8)));
            }

            testCaseList.add(jsonObject);
        }

        result.set("testCases", testCaseList);

        FileWriter infoFile = new FileWriter(testCaseDir + "/info", CharsetUtil.UTF_8);
        // 写入记录文件
        infoFile.write(JSONUtil.toJsonStr(result));
        // 删除临时上传文件夹
        FileUtil.del(tmpTestcaseDir);
        // 删除非测试数据的文件
        listFileNames.remove("info");
        if(!CollectionUtils.isEmpty(listFileNames)) {
            for(String filename: listFileNames) {
                FileUtil.del(testCaseDir + File.separator + filename);
            }
        }
    }

    // 初始化手动输入上传的测试数据，写成json文件
    @Async
    public void initHandTestCase(String judgeMode,
                                 String judgeCaseMode,
                                 String version,
                                 Long problemId,
                                 List<ProblemCase> problemCaseList) {
        JSONObject result = new JSONObject();
        result.set("mode", judgeMode);
        if(StringUtils.isEmpty(judgeCaseMode)) {
            judgeCaseMode = Constants.JudgeCaseMode.DEFAULT.getMode();
        }
        result.set("judgeCaseMode", judgeCaseMode);
        result.set("version", version);
        result.set("testCasesSize", problemCaseList.size());

        JSONArray testCaseList = new JSONArray(problemCaseList.size());

        String testCaseDir = Constants.File.TESTCASE_BASE_FOLDER.getPath() + File.separator + "problem_" + problemId;
        FileUtil.del(testCaseDir);
        for(int index = 0; index < problemCaseList.size(); index ++) {
            JSONObject jsonObject = new JSONObject();
            String inputName = (index + 1) + ".in";
            jsonObject.set("caseId", problemCaseList.get(index).getId());
            if(judgeCaseMode.equals(Constants.JudgeCaseMode.SUBTASK_AVERAGE.getMode())
                    || judgeCaseMode.equals(Constants.JudgeCaseMode.SUBTASK_LOWEST.getMode())) {
                jsonObject.set("groupNum", problemCaseList.get(index).getGroupNum());
            }
            jsonObject.set("score", problemCaseList.get(index).getScore());
            jsonObject.set("inputName", inputName);
            // 生成对应文件
            FileWriter  infileWrite = new FileWriter(testCaseDir + "/" + inputName, CharsetUtil.UTF_8);
            // 将该测试数据的输入写入到文件
            String inputData = problemCaseList
                    .get(index)
                    .getInput()
                    .replaceAll("\r\n", "\n") // 避免window系统的换行问题
                    .replaceAll("\r", "\n"); // 避免mac系统的换行问题
            infileWrite.write(inputData);

            String outputName = (index + 1) + ".out";
            jsonObject.set("outputName", outputName);
            // 生成对应文件
            String outputData = problemCaseList
                    .get(index)
                    .getOutput()
                    .replaceAll("\r\n", "\n") // 避免window系统的换行问题
                    .replaceAll("\r", "\n"); // 避免mac系统的换行问题
            FileWriter outFile = new FileWriter(testCaseDir + "/" + outputName, CharsetUtil.UTF_8);
            outFile.write(outputData);

            // spj和interactive是根据特判程序输出判断结果，所以无需初始化测试数据
            if(Constants.JudgeMode.DEFAULT.getMode().equals(judgeCaseMode)) {
// 原数据MD5
                jsonObject.set("outputMd5", DigestUtils.md5DigestAsHex(outputData.getBytes(StandardCharsets.UTF_8)));
                // 原数据大小
                jsonObject.set("outputSize", outputData.getBytes(StandardCharsets.UTF_8).length);
                // 去掉全部空格的MD5，用来判断pe
                jsonObject.set("allStrippedOutputMd5", DigestUtils.md5DigestAsHex(outputData.replaceAll("\\s+", "").getBytes(StandardCharsets.UTF_8)));
                // 默认去掉文末空格的MD5
                jsonObject.set("EOFStrippedOutputMd5",DigestUtils.md5DigestAsHex(rtrim(outputData).getBytes(StandardCharsets.UTF_8)));
            }

            testCaseList.add(jsonObject);
        }

        result.set("testCases", testCaseList);

        FileWriter infoFile = new FileWriter(testCaseDir + "/info", CharsetUtil.UTF_8);
        // 写入记录文件
        infoFile.write(JSONUtil.toJsonStr(result));
    }


    private Integer calProblemTotalScore(String judgeCaseMode, List<ProblemCase> problemCaseList) {

        int sumScore = 0;
        if(Constants.JudgeCaseMode.SUBTASK_LOWEST.getMode().equals(judgeCaseMode)) {
            HashMap<Integer, Integer> groupNumMapScore = new HashMap<>();
            for(ProblemCase problemCase: problemCaseList) {
                groupNumMapScore.merge(problemCase.getGroupNum(), problemCase.getScore(), Math::min);
            }
            for(Integer minScore: groupNumMapScore.values()) {
                sumScore += minScore;
            }
        } else if(Constants.JudgeCaseMode.SUBTASK_AVERAGE.getMode().equals(judgeCaseMode)) {
            // 预处理 切换成Map Key: groupNum Value: <count,sum_score>
            HashMap<Integer, Pair_<Integer,Integer>> groupNumMapScore = new HashMap<>();
            for(ProblemCase problemCase: problemCaseList) {
                Pair_<Integer,Integer> pair = groupNumMapScore.get(problemCase.getGroupNum());
                if(pair == null) {
                    groupNumMapScore.put(problemCase.getGroupNum(), new Pair_<>(1, problemCase.getScore()));
                } else {
                    int count = pair.getKey() + 1;
                    int score = pair.getValue() + problemCase.getScore();
                    groupNumMapScore.put(problemCase.getGroupNum(), new Pair_<>(count, score));
                }
            }
            for(Pair_<Integer,Integer> pair: groupNumMapScore.values()) {
                sumScore += Math.round(pair.getValue() * 1.0 / pair.getKey());
            }
        } else {
            for(ProblemCase problemCase: problemCaseList) {
                if(problemCase.getScore() != null) {
                    sumScore += problemCase.getScore();
                }
            }
        }
        return sumScore;
    }

    // 去除每行末尾的空白符
    public static String rtrim(String value) {
        if(value == null) {
            return  null;
        }
        return EOL_PATTERN.matcher(StrUtil.trimEnd(value)).replaceAll("");
    }
}
