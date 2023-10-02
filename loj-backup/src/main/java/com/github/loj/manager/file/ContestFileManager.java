package com.github.loj.manager.file;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.file.FileReader;
import cn.hutool.core.io.file.FileWriter;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.ZipUtil;
import cn.hutool.json.JSONUtil;
import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestPrintEntityService;
import com.github.loj.dao.contest.ContestProblemEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.manager.oj.ContestCalculateRankManager;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestPrint;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.vo.ACMContestRankVO;
import com.github.loj.pojo.vo.OIContestRankVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.ContestValidator;
import com.github.loj.validator.GroupValidator;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

@Component
@Slf4j(topic = "loj")
public class ContestFileManager {

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private ContestValidator contestValidator;

    @Autowired
    private ContestProblemEntityService contestProblemEntityService;

    @Autowired
    private ContestPrintEntityService contestPrintEntityService;

    @Autowired
    private ContestCalculateRankManager contestCalculateRankManager;

    @Autowired
    private FileEntityService fileEntityService;

    @Autowired
    private UserInfoEntityService userInfoEntityService;

    @Autowired
    private JudgeEntityService judgeEntityService;

    public void downloadContestRank(Long cid, Boolean forceRefresh, Boolean removeStar, HttpServletResponse response) throws StatusFailException, StatusForbiddenException, IOException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 获取本场比赛的状态
        Contest contest = contestEntityService.getById(cid);

        if(contest == null) {
            throw new StatusFailException("错误：该比赛不存在！");
        }

        // 是否为超级管理员
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long gid = contest.getGid();

        if(!isRoot
            && !contest.getUid().equals(userRolesVo.getUid())
            && !contest.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("错误：您并非该比赛的管理员，无权下载榜单！");
        }

        // 检查是否需要开启封榜模式
        boolean isOpenSealRank = contestValidator.isSealRank(userRolesVo.getUid(), contest, forceRefresh, isRoot);
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("utf-8");
        // 这里URLEncoder.encode可以防止中文乱码
        String fileName = URLEncoder.encode("contest_" + contest.getId() + "_rank", "UTF-8");
        response.setHeader("Content-disposition", "attachment;filename=" + fileName + ".xlsx");
        response.setHeader("Content-Type", "application/xlsx");

        // 获取题目displayID列表
        QueryWrapper<ContestProblem> contestProblemQueryWrapper = new QueryWrapper<>();
        contestProblemQueryWrapper.eq("cid", contest.getId()).select("display_id").orderByAsc("display_id");
        List<String> contestProblemDisplayIDList = contestProblemEntityService.list(contestProblemQueryWrapper)
                .stream().map(ContestProblem::getDisplayId).collect(Collectors.toList());

        if(contest.getType().intValue() == Constants.Contest.TYPE_ACM.getCode()) { // ACM比赛
            List<ACMContestRankVO> acmContestRankVOList = contestCalculateRankManager.calcACMRank(
                    isOpenSealRank,
                    removeStar,
                    contest,
                    null,
                    null,
                    null);

            EasyExcel.write(response.getOutputStream())
                    .head(fileEntityService.getContestRankExcelHead(contestProblemDisplayIDList, true))
                    .sheet("rank")
                    .doWrite(fileEntityService.changeACMContestRankToExcelRowList(acmContestRankVOList, contestProblemDisplayIDList, contest.getRankShowName()));
        } else {
            List<OIContestRankVO> oiContestRankVOList = contestCalculateRankManager.calcOIRank(
                    isOpenSealRank,
                    removeStar,
                    contest,
                    null,
                    null,
                    null);

            EasyExcel.write(response.getOutputStream())
                    .head(fileEntityService.getContestRankExcelHead(contestProblemDisplayIDList, false))
                    .sheet("rank")
                    .doWrite(fileEntityService.changOIContestRankToExcelRowList(oiContestRankVOList, contestProblemDisplayIDList, contest.getRankShowName()));

        }
    }

    public void downloadContestACSubmission(Long cid, Boolean excludeAdmin, String splitType, HttpServletResponse response) throws StatusFailException, StatusForbiddenException {
        Contest contest = contestEntityService.getById(cid);

        if (contest == null) {
            throw new StatusFailException("错误：该比赛不存在！");
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        // 除非是root 其它管理员只能下载自己的比赛ac记录

        Long gid = contest.getGid();
        if (!isRoot
                && !contest.getUid().equals(userRolesVo.getUid())
                && !(contest.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), gid))) {
            throw new StatusForbiddenException("错误：您并非该比赛的管理员，无权下载AC记录！");
        }

        boolean isACM = contest.getType().intValue() == Constants.Contest.TYPE_ACM.getCode();

        QueryWrapper<ContestProblem> contestProblemQueryWrapper = new QueryWrapper<>();
        contestProblemQueryWrapper.eq("cid", contest.getId());
        List<ContestProblem> contestProblemList = contestProblemEntityService.list(contestProblemQueryWrapper);

        List<String> superAdminUidList = userInfoEntityService.getSuperAdminUidList();

        QueryWrapper<Judge> judgeQueryWrapper = new QueryWrapper<>();
        judgeQueryWrapper.eq("cid", cid)
                .eq(isACM, "status", Constants.Judge.STATUS_ACCEPTED.getStatus())
                .isNotNull(!isACM, "score") // OI模式取得分不为null的
                .between("submit_time",contest.getStartTime(),contest.getEndTime())
                .ne("uid", contest.getUid()) // 排除比赛创建者和root
                .notIn(excludeAdmin && superAdminUidList.size() > 0, "uid", superAdminUidList)
                .orderByDesc("submit_time");

        List<Judge> judgeList = judgeEntityService.list(judgeQueryWrapper);
        // 打包文件的临时路径 -> username为文件夹名字
        String tmpFileDir = Constants.File.CONTEST_AC_SUBMISSION_TMP_FOLDER.getPath() + "/" + IdUtil.fastSimpleUUID();
        FileUtil.mkdir(tmpFileDir);

        HashMap<String,Boolean> recordMap = new HashMap<>();
        if ("user".equals(splitType)) {
            /**
             * 以用户来分割提交的代码
             */
            List<String> usernameList = judgeList.stream()
                    .filter(distinctByKey(Judge::getUsername)) // 根据用户名过滤唯一
                    .map(Judge::getUsername).collect(Collectors.toList()); // 映射出用户名列表

            HashMap<Long, String> cpIdMap = new HashMap<>();
            for (ContestProblem contestProblem: contestProblemList) {
                cpIdMap.put(contestProblem.getId(), contestProblem.getDisplayId());
            }

            for (String username: usernameList) {
                // 对于每个用户生成对应的文件夹
                String userDir = tmpFileDir + "/" + username;
                FileUtil.mkdir(userDir);
                // 如果是ACM模式，则所有提交代码都要生成，如果同一题多次提交AC，加上提交时间秒后缀 ---> A_(666666).c
                // 如果是OI模式就生成最近一次提交即可，且带上分数 ---> A_(666666)_100.c
                List<Judge> userSubmissionList = judgeList.stream()
                        .filter(judge -> judge.getUsername().equals(username)) // 过滤出对应用户的提交
                        .sorted(Comparator.comparing(Judge::getSubmitTime).reversed()) // 根据提交时间进行降序
                        .collect(Collectors.toList());

                for (Judge judge: userSubmissionList) {
                    String filePath = userDir + "/" + cpIdMap.getOrDefault(judge.getCpid(), "null");

                    // OI模式只取最后一次提交
                    if (!isACM) {
                        String key = judge.getUsername() + "_" + judge.getPid();
                        if (!recordMap.containsKey(key)) {
                            filePath += "_" + judge.getScore() + "_(" + threadLocalTime.get().format(judge.getSubmitTime()) + ")."
                                    + languageToFileSuffix(judge.getLanguage().toLowerCase());
                            FileWriter fileWriter = new FileWriter(filePath);
                            fileWriter.write(judge.getCode());
                            recordMap.put(key, true);
                        }
                    } else {
                        filePath += "_(" + threadLocalTime.get().format(judge.getSubmitTime()) + ")."
                                + languageToFileSuffix(judge.getLanguage().toLowerCase());
                        FileWriter fileWriter = new FileWriter(filePath);
                        fileWriter.write(judge.getCode());
                    }
                }
            }
        } else if ("problem".equals(splitType)) {
            /**
             * 以比赛题目编号来分割提交的代码
             */
            for (ContestProblem contestProblem: contestProblemList) {
                // 对于每题目生成对应的文件夹
                String problemDir = tmpFileDir + "/" + contestProblem.getDisplayId();
                FileUtil.mkdir(problemDir);
                // 如果是ACM模式，则所有提交代码都要生成，如果同一题多次提交AC，加上提交时间秒后缀 ---> username_(666666).c
                // 如果是OI模式就生成最近一次提交即可，且带上分数 ---> username_(666666)_100.c
                List<Judge> problemSubmissionList = judgeList.stream()
                        .filter(judge -> judge.getPid().equals(contestProblem.getPid()))
                        .sorted(Comparator.comparing(Judge::getSubmitTime).reversed())
                        .collect(Collectors.toList());

                for (Judge judge : problemSubmissionList) {
                    String filePath = problemDir + "/" + judge.getUsername();
                    if (!isACM) {
                        String key = judge.getUsername() + "_" + contestProblem.getDisplayId();
                        // OI模式只取最后一次提交
                        if (!recordMap.containsKey(key)) {
                            filePath += "_" + judge.getScore() + "_(" + threadLocalTime.get().format(judge.getSubmitTime()) + ")."
                                    + languageToFileSuffix(judge.getLanguage().toLowerCase());
                            FileWriter fileWriter = new FileWriter(filePath);
                            fileWriter.write(judge.getCode());
                            recordMap.put(key, true);
                        }
                    } else {
                        filePath += "_(" + threadLocalTime.get().format(judge.getSubmitTime()) + ")."
                                + languageToFileSuffix(judge.getLanguage().toLowerCase());
                        FileWriter fileWriter = new FileWriter(filePath);
                        fileWriter.write(judge.getCode());
                    }
                }
            }
        }

        String zipFileName = "contest_" + contest.getId() + "_" + System.currentTimeMillis() + ".zip";
        String zipPath = Constants.File.CONTEST_AC_SUBMISSION_TMP_FOLDER.getPath() + "/" + zipFileName;
        ZipUtil.zip(tmpFileDir,zipPath);

        // 将zip变成io流返回给前端
        FileReader zipFileReader = new FileReader(zipPath);
        BufferedInputStream bins = new BufferedInputStream(zipFileReader.getInputStream()); //放到缓冲流里面
        OutputStream outs = null; //获取文件输出IO流
        BufferedOutputStream bouts = null;

        try {
            outs = response.getOutputStream();
            bouts = new BufferedOutputStream(outs);
            response.setContentType("application/x-download");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(zipFileName, "UTF-8"));
            int bytesRead = 0;
            byte[] buffer = new byte[1024 * 10];
            //开始向网络传输文件流
            while((bytesRead = bins.read(buffer, 0, 1024 * 10)) != -1) {
                bouts.write(buffer, 0, bytesRead);
            }
            // 刷新缓存
            bouts.flush();
        } catch (IOException e) {
            log.error("下载比赛AC提交代码的压缩文件异常------------>", e);
            response.reset();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            Map<String,Object> map = new HashMap<>();
            map.put("status", ResultStatus.SYSTEM_ERROR);
            map.put("msg", "下载文件失败，请重新尝试！");
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
        }

        FileUtil.del(tmpFileDir);
        FileUtil.del(zipPath);
    }


    public void downloadContestPrintText(Long id, HttpServletResponse response) throws StatusForbiddenException {
        ContestPrint contestPrint = contestPrintEntityService.getById(id);
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long cid = contestPrint.getCid();

        Contest contest = contestEntityService.getById(cid);

        Long gid = contest.getGid();

        if (!isRoot && !contest.getUid().equals(userRolesVo.getUid())
                && !(contest.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), gid))) {
            throw new StatusForbiddenException("错误：您并非该比赛的管理员，无权下载打印代码！");
        }
        String filename = contestPrint.getUsername() + "_Contest_Print.txt";
        String filePath = Constants.File.CONTEST_TEXT_PRINT_FOLDER.getPath() + "/" + id + "/" + filename;
        if (!FileUtil.exist(filePath)) {
            FileWriter fileWriter = new FileWriter(filePath);
            fileWriter.write(contestPrint.getContent());
        }

        FileReader zipFileReader = new FileReader(filePath);
        BufferedInputStream bins = new BufferedInputStream(zipFileReader.getInputStream());//放到缓冲流里面
        OutputStream outs = null;//获取文件输出IO流
        BufferedOutputStream bouts = null;
        try {
            outs = response.getOutputStream();
            bouts = new BufferedOutputStream(outs);
            response.setContentType("application/x-download");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
            int bytesRead = 0;
            byte[] buffer = new byte[1024 * 10];
            //开始向网络传输文件流
            while((bytesRead = bins.read(buffer, 0, 1024 * 10)) != -1) {
                bouts.write(buffer, 0, bytesRead);
            }
            // 刷新缓存
            bouts.flush();
        } catch (IOException e) {
            log.error("下载比赛打印文本文件异常------------>", e);
            response.reset();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            Map<String, Object> map = new HashMap<>();
            map.put("status", ResultStatus.SYSTEM_ERROR);
            map.put("msg", "下载文件失败，请重新尝试！");
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
        }
    }

    private static final ThreadLocal<SimpleDateFormat> threadLocalTime = new ThreadLocal<SimpleDateFormat>() {
        @Override
        protected SimpleDateFormat initialValue() {
            return new SimpleDateFormat("yyyyMMddHHmmss");
        }
    };

    private static<T>Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
        Map<Object, Boolean> seen  = new ConcurrentHashMap<>();
        return t -> seen.putIfAbsent(keyExtractor.apply(t), Boolean.TRUE) == null;
    }

    private static String languageToFileSuffix(String language) {

        List<String> CLang = Arrays.asList("c","gcc","clang");
        List<String> CPPLang = Arrays.asList("c++", "g++", "clang++");
        List<String> PythonLang = Arrays.asList("python", "pypy");

        for (String lang: CPPLang) {
            if (language.contains(lang)) {
                return "cpp";
            }
        }

        if (language.contains("c#")) {
            return "cs";
        }

        for (String lang : CLang) {
            if (language.contains(lang)) {
                return "c";
            }
        }

        for (String lang : PythonLang) {
            if (language.contains(lang)) {
                return "py";
            }
        }

        if (language.contains("javascript")) {
            return "js";
        }

        if (language.contains("java")) {
            return "java";
        }

        if (language.contains("pascal")) {
            return "pas";
        }

        if (language.contains("go")) {
            return "go";
        }

        if (language.contains("php")) {
            return "php";
        }

        return "txt";
    }
}
