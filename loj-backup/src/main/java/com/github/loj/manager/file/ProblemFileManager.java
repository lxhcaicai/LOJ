package com.github.loj.manager.file;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.file.FileReader;
import cn.hutool.core.io.file.FileWriter;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.ZipUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.dao.problem.LanguageEntityService;
import com.github.loj.dao.problem.ProblemCaseEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.problem.TagEntityService;
import com.github.loj.pojo.entity.problem.Language;
import com.github.loj.pojo.entity.problem.ProblemCase;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.pojo.vo.ImportProblemVO;
import com.github.loj.utils.Constants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import java.util.concurrent.*;

@Component
@Slf4j(topic = "loj")
public class ProblemFileManager {

    @Autowired
    private LanguageEntityService languageEntityService;

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private ProblemCaseEntityService problemCaseEntityService;

    @Autowired
    private TagEntityService tagEntityService;

    /**
     * 导出指定的题目包括测试数据生成zip 仅超级管理员可操作
     * @param pidList
     * @param response
     */
    public void exportProblem(List<Long> pidList, HttpServletResponse response) {

        QueryWrapper<Language> languageQueryWrapper = new QueryWrapper<>();
        languageQueryWrapper.eq("oj","ME");
        List<Language> languageList = languageEntityService.list(languageQueryWrapper);

        HashMap<Long, String> languageMap = new HashMap<>();
        for(Language language: languageList) {
            languageMap.put(language.getId(), language.getName());
        }

        List<Tag> tagList = tagEntityService.list();
        HashMap<Long, String> tagMap = new HashMap<>();
        for(Tag tag: tagList) {
            tagMap.put(tag.getId(), tag.getName());
        }

        String workDir = Constants.File.FILE_DOWNLOAD_TMP_FOLDER.getPath() + "/" + IdUtil.simpleUUID();

        // 使用线程池
        ExecutorService threadPool = new ThreadPoolExecutor(
                2, // 核心线程数
                4, // 最大线程数。最多几个线程并发。
                3,//当非核心线程无任务时，几秒后结束该线程
                TimeUnit.SECONDS,// 结束线程时间单位
                new LinkedBlockingDeque<>(200), //阻塞队列，限制等候线程数
                Executors.defaultThreadFactory(),
                new ThreadPoolExecutor.DiscardOldestPolicy());//队列满了，尝试去和最早的竞争，也不会抛出异常！

        List<FutureTask<Void>> futureTasks = new ArrayList<>();

        for(Long pid: pidList) {
            futureTasks.add(new FutureTask<>(new Callable<Void>() {
                @Override
                public Void call() throws Exception {
                    String testcaseWorkDir = Constants.File.TESTCASE_BASE_FOLDER.getPath() + "/" + "problem_" + pid;
                    File file = new File(testcaseWorkDir);

                    List<HashMap<String, Object>> problemCases = new LinkedList<>();
                    if(!file.exists() || file.listFiles() == null) { // 本地为空 尝试去数据库查找
                        QueryWrapper<ProblemCase> problemCaseQueryWrapper = new QueryWrapper<>();
                        problemCaseQueryWrapper.eq("pid", pid);
                        List<ProblemCase> problemCaseList = problemCaseEntityService.list(problemCaseQueryWrapper);
                        FileUtil.mkdir(testcaseWorkDir);
                        // 写入本地
                        for(int i = 0; i < problemCaseList.size(); i ++) {
                            String filePreName = testcaseWorkDir + "/" + (i + 1);
                            String inputName = filePreName +".in";
                            String outputName = filePreName + ".out";
                            FileWriter infileWriter = new FileWriter(inputName);
                            infileWriter.write(problemCaseList.get(i).getInput());
                            FileWriter outfileWriter = new FileWriter(outputName);
                            outfileWriter.write(problemCaseList.get(i).getOutput());

                            ProblemCase problemCase = problemCaseList.get(i).setPid(null)
                                    .setInput(inputName)
                                    .setOutput(outputName)
                                    .setGmtCreate(null)
                                    .setStatus(null)
                                    .setId(null)
                                    .setGmtModified(null);

                            HashMap<String,Object> problemCaseMap = new HashMap<>();
                            BeanUtil.beanToMap(problemCase, problemCaseMap, false, true);
                            problemCases.add(problemCaseMap);
                        }
                        FileUtil.copy(testcaseWorkDir, workDir, true);
                    } else {
                        String infoPath = testcaseWorkDir + "/" + "info";
                        if (FileUtil.exist(infoPath)) {
                            FileReader reader = new FileReader(infoPath);
                            JSONObject jsonObject = JSONUtil.parseObj(reader.readString());
                            JSONArray testCases = jsonObject.getJSONArray("testCases");
                            for(int i = 0; i < testCases.size(); i ++) {
                                JSONObject jsonObject1 = testCases.get(i, JSONObject.class);
                                HashMap<String, Object> problemCaseMap = new HashMap<>();
                                problemCaseMap.put("input",jsonObject1.getStr("inputName"));
                                problemCaseMap.put("output", jsonObject1.getStr("outputName"));
                                Integer score = jsonObject1.getInt("score");
                                Integer groupNum = jsonObject1.getInt("groupNum");
                                if (score != null && score > 0) {
                                    problemCaseMap.put("score", score);
                                }
                                if (groupNum != null) {
                                    problemCaseMap.put("groupNum", groupNum);
                                }
                                problemCases.add(problemCaseMap);
                            }
                        }
                        FileUtil.copy(testcaseWorkDir, workDir, true);
                    }
                    ImportProblemVO importProblemVO = problemEntityService.buildExportProblem(pid, problemCases, languageMap, tagMap);
                    String content = JSONUtil.toJsonStr(importProblemVO);
                    FileWriter fileWriter = new FileWriter(workDir + "/" + "problem_" + pid + ".json");
                    fileWriter.write(content);
                    return null;
                }
            }));
        }
        // 提交到线程池进行执行
        for(FutureTask<Void> futureTask: futureTasks) {
            threadPool.submit(futureTask);
        }
        // 所有任务执行完成且等待队列中也无任务关闭线程池
        if (!threadPool.isShutdown()) {
            threadPool.shutdown();
        }
        // 阻塞主线程, 直至线程池关闭
        try {
            threadPool.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS);
        } catch (InterruptedException e) {
            log.error("线程池异常--------------->", e);
        }

        String fileName = "problem_export" + System.currentTimeMillis() + ".zip";
        // 将对应文件夹的文件压缩成zip
        ZipUtil.zip(workDir, Constants.File.FILE_DOWNLOAD_TMP_FOLDER.getPath() + "/" + fileName);
        // 将zip变成io流返回给前端
        FileReader fileReader = new FileReader(Constants.File.FILE_DOWNLOAD_TMP_FOLDER.getPath() + "/" + fileName);
        BufferedInputStream bins = new BufferedInputStream(fileReader.getInputStream());//放到缓冲流里面
        OutputStream outs = null; //获取文件输出IO流
        BufferedOutputStream bouts = null;
        try {
            outs = response.getOutputStream();
            bouts = new BufferedOutputStream(outs);
            response.setContentType("application/x-download");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
            int butesRead = 0;
            byte[] buffer = new byte[1024 * 10];
            //开始向网络传输文件流
            while((butesRead = bins.read(buffer, 0, 1024 * 10)) != -1) {
                bouts.write(buffer, 0, butesRead);
            }
            bouts.flush();
        } catch (IOException e) {
            log.error("导出题目数据的压缩文件异常------------>", e);
            response.reset();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            Map<String,Object> map = new HashMap<>();
            map.put("status", ResultStatus.SYSTEM_ERROR);
            map.put("msg", "导出题目数据失败，请重新尝试！");
            map.put("data", null);
            try {
                response.getWriter().println(JSONUtil.toJsonStr(map));
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                bins.close();
                if (outs != null) {
                    outs.close();
                }
                if (bouts != null) {
                    bouts.close();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
            // 清空临时文件
            FileUtil.del(workDir);
            FileUtil.del(Constants.File.FILE_DOWNLOAD_TMP_FOLDER + "/" + fileName);
        }
    }
}
