package com.github.loj.manager.oj;

import cn.hutool.core.util.IdUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.LOJAccessEnum;
import com.github.loj.common.exception.*;
import com.github.loj.config.NacosSwitchConfig;
import com.github.loj.config.SwitchConfig;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestRecordEntityService;
import com.github.loj.dao.judge.JudgeCaseEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.user.UserAcproblemEntityService;
import com.github.loj.judge.remote.RemoteJudgeDispatcher;
import com.github.loj.judge.self.JudgeDispatcher;
import com.github.loj.pojo.dto.*;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.judge.JudgeCase;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.user.UserAcproblem;
import com.github.loj.pojo.vo.*;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.utils.IpUtils;
import com.github.loj.utils.RedisUtils;
import com.github.loj.validator.AccessValidator;
import com.github.loj.validator.ContestValidator;
import com.github.loj.validator.GroupValidator;
import com.github.loj.validator.JudgeValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.rmi.AccessException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/6 22:09
 */
@Component
public class JudgeManager {

    @Autowired
    private ContestRecordEntityService contestRecordEntityService;

    @Autowired
    private UserAcproblemEntityService userAcproblemEntityService;

    @Autowired
    private JudgeCaseEntityService judgeCaseEntityService;

    @Autowired
    private JudgeEntityService judgeEntityService;

    @Autowired
    private JudgeValidator judgeValidator;

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private JudgeDispatcher judgeDispatcher;

    @Autowired
    private NacosSwitchConfig nacosSwitchConfig;

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private ContestValidator contestValidator;

    @Autowired
    private RemoteJudgeDispatcher remoteJudgeDispatcher;

    @Autowired
    private AccessValidator accessValidator;

    @Autowired
    private BeforeDispatchInitManager beforeDispatchInitManager;

    public String submitProblemTestJudge(TestJudgeDTO testJudgeDTO) throws AccessException,
            StatusFailException, StatusForbiddenException, StatusSystemErrorException {
        judgeValidator.validateTestJudgeInfo(testJudgeDTO);
        // 需要获取一下该token对应用户的数据
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        String lockKey = Constants.Account.TEST_JUDGE_LOCK.getCode() + userRolesVo.getUid();
        long count = redisUtils.incr(lockKey,1);
        if(count > 1) {
            throw new StatusForbiddenException("对不起，您使用在线调试过于频繁，请稍后再尝试！");
        }
        redisUtils.expire(lockKey, 3);

        Problem problem = problemEntityService.getById(testJudgeDTO.getPid());

        if(problem == null) {
            throw new StatusFailException("当前题目不存在！不支持在线调试！");
        }

        String uniqueKey = "TEST_JUDGE_" + IdUtil.simpleUUID();

        TestJudgeReq testJudgeReq = new TestJudgeReq();
        testJudgeReq.setMemoryLimit(problem.getMemoryLimit())
                .setTimeLimit(problem.getTimeLimit())
                .setStackLimit(problem.getStackLimit())
                .setCode(testJudgeDTO.getCode())
                .setLanguage(testJudgeDTO.getLanguage())
                .setUniqueKey(uniqueKey)
                .setExpectedOutput(testJudgeDTO.getExpectedOutput())
                .setTestCaseInput(testJudgeDTO.getUserInput())
                .setProblemJudgeMode(problem.getJudgeMode())
                .setIsRemoveEndBlank(problem.getIsRemoveEndBlank() || problem.getIsRemote());

        String userExtraFile = problem.getUserExtraFile();
        if(!StringUtils.isEmpty(userExtraFile)) {
            testJudgeReq.setExtraFile((HashMap<String, String>) JSONUtil.toBean(userExtraFile, Map.class));
        }
        judgeDispatcher.sendTestJudgeTask(testJudgeReq);
        redisUtils.set(uniqueKey, TestJudgeRes.builder()
                .status(Constants.Judge.STATUS_PENDING.getStatus())
                .build(),10*60);
        return uniqueKey;
    }

    public TestJudgeVO getTestJudgeResult(String testJudgeKey) throws StatusFailException {
        TestJudgeRes testJudgeRes = (TestJudgeRes) redisUtils.get(testJudgeKey);
        if(testJudgeRes == null) {
            throw new StatusFailException("查询错误！当前在线调试任务不存在！");
        }
        TestJudgeVO testJudgeVO = new TestJudgeVO();
        testJudgeVO.setStatus(testJudgeRes.getStatus());
        if(Constants.Judge.STATUS_PENDING.getStatus().equals(testJudgeRes.getStatus())) {
            return testJudgeVO;
        }
        testJudgeVO.setUserInput(testJudgeRes.getInput());
        testJudgeVO.setUserOutput(testJudgeRes.getStdout());
        testJudgeVO.setExpectedOutput(testJudgeRes.getExpectedOutput());
        testJudgeVO.setMemory(testJudgeRes.getMemory());
        testJudgeVO.setTime(testJudgeRes.getTime());
        testJudgeVO.setStderr(testJudgeRes.getStderr());
        testJudgeVO.setProblemJudgeMode(testJudgeRes.getProblemJudgeMode());
        redisUtils.del(testJudgeKey);
        return testJudgeVO;
    }

    public Judge submitProblemJudge(SubmitJudgeDTO judgeDTO) throws AccessException, StatusFailException, StatusForbiddenException, StatusAccessDeniedException {
        judgeValidator.validateSubmissionInfo(judgeDTO);

        // 需要获取一下该token对应用户的数据
        AccountProfile userRoleVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isContestSubmission = judgeDTO.getCid() != null && judgeDTO.getCid() != 0;
        boolean isTrainingSubmission = judgeDTO.getTid() != null && judgeDTO.getTid() != 0;

        SwitchConfig switchConfig = nacosSwitchConfig.getSwitchConfig();
        if(!isContestSubmission && switchConfig.getDefaultSubmitInterval() > 0) { // 非比赛提交有限制限制
            String lockKey = Constants.Account.SUBMIT_CONTEST_LOCK.getCode() + userRoleVo.getUid();
            long count = redisUtils.incr(lockKey, 1);
            if(count > 1) {
                throw new StatusForbiddenException("对不起，您的提交频率过快，请稍后再尝试！");
            }
            redisUtils.expire(lockKey, switchConfig.getDefaultSubmitInterval());
        }

        HttpServletRequest request = ((ServletRequestAttributes) (RequestContextHolder.currentRequestAttributes())).getRequest();

        // 将提交先写入数据库，准备调用判题服务器
        Judge judge = new Judge();
        judge.setShare(false)
                .setCode(judgeDTO.getCode())
                .setCid(judgeDTO.getCid())
                .setGid(judgeDTO.getGid())
                .setLanguage(judgeDTO.getLanguage())
                .setLength(judgeDTO.getCode().length())
                .setUid(userRoleVo.getUid())
                .setUsername(userRoleVo.getUsername())
                .setStatus(Constants.Judge.STATUS_PENDING.getStatus()) // 开始进入判题队列
                .setSubmitTime(new Date())
                .setVersion(0)
                .setIp(IpUtils.getUserIpAddr(request));

        // 如果比赛id不等于0，则说明为比赛提交
        if(isContestSubmission) {
            beforeDispatchInitManager.initContestSubmission(judgeDTO.getCid(),judgeDTO.getPid(),userRoleVo, judge);
        } else if(isTrainingSubmission) {
            beforeDispatchInitManager.initTrainingSubmission(judgeDTO.getTid(), judgeDTO.getPid(), userRoleVo, judge);
        } else {
            beforeDispatchInitManager.initCommonSubmission(judgeDTO.getPid(), judgeDTO.getGid(), judge);
        }

        // 将提交加入任务队列
        if(judgeDTO.getIsRemote()) { // 如果是远程oj判题
            remoteJudgeDispatcher.sendTask(judge.getSubmitId(),
                    judge.getPid(),
                    judge.getDisplayPid(),
                    isContestSubmission,
                    false);
        } else {
            judgeDispatcher.sendTask(judge.getSubmitId(),
                    judge.getPid(),
                    isContestSubmission);
        }

        return judge;
    }

    public SubmissionInfoVO getSubmission(Long submitId) throws StatusNotFoundException, StatusAccessDeniedException {
        Judge judge = judgeEntityService.getById(submitId);
        if(judge == null) {
            throw new StatusNotFoundException("此提交数据不存在！");
        }

        AccountProfile userRoleVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root"); // 是否为超级管理员
        // 清空vj信息

        judge.setVjudgeUsername(null);
        judge.setVjudgePassword(null);
        judge.setVjudgeSubmitId(null);

        // 超级管理员与题目管理员有权限查看代码
        // 如果不是本人或者并未分享代码，则不可查看
        // 当此次提交代码不共享
        // 比赛提交只有比赛创建者和root账号可看代码
        SubmissionInfoVO submissionInfoVO = new SubmissionInfoVO();

        if(judge.getCid() != 0) {
            if(userRoleVo == null) {
                throw new StatusAccessDeniedException("请先登录！");
            }
            Contest contest = contestEntityService.getById(judge.getCid());
            if(!isRoot && !userRoleVo.getUid().equals(contest.getUid())
                    && !(judge.getGid() != null && groupValidator.isGroupRoot(userRoleVo.getUid(), judge.getGid()))) {
                // 如果是比赛,那么还需要判断是否为封榜,比赛管理员和超级管理员可以有权限查看(ACM题目除外)
                if(contest.getType().intValue() == Constants.Contest.TYPE_OI.getCode()
                        && contestValidator.isSealRank(userRoleVo.getUid(), contest, true, false)) {
                    submissionInfoVO.setSubmission(new Judge().setStatus(Constants.Judge.STATUS_SUBMITTED_UNKNOWN_RESULT.getStatus()));
                    return submissionInfoVO;
                }
                // 不是本人的话不能查看代码、时间，空间，长度
                if(!userRoleVo.getUid().equals(judge.getUid())) {
                    judge.setCode(null);
                    // 如果还在比赛时间，不是本人不能查看时间，空间，长度，错误提示信息
                    if(contest.getStatus().intValue() == Constants.Contest.STATUS_RUNNING.getCode()) {
                        judge.setTime(null);
                        judge.setMemory(null);
                        judge.setLength(null);
                        judge.setErrorMessage("The contest is in progress. You are not allowed to view other people's error information.");
                    }
                }
            }
            // 团队比赛的提交代码 如果不是超管，需要检查网站是否开启隐藏代码功能
            if(!isRoot && contest.getIsGroup() && judge.getCode() != null) {
                try {
                    accessValidator.validateAccess(LOJAccessEnum.HIDE_NON_CONTEST_SUBMISSION_CODE);
                } catch (AccessException e) {
                    judge.setCode("Because the super administrator has enabled " +
                            "the function of not viewing the submitted code outside the contest of master station, \n" +
                            "the code of this submission details has been hidden.");
                }
            }
        } else {
            boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin"); // 是否为题目管理员
            if(!judge.getShare()
                    && !isRoot
                    && !isProblemAdmin
                    && !(judge.getGid() != null && groupValidator.isGroupRoot(userRoleVo.getUid(), judge.getGid()))) {

                if(userRoleVo != null) {// 当前是登陆状态
                    // 需要判断是否为当前登陆用户自己的提交代码
                    if(!judge.getUid().equals(userRoleVo.getUid())) {
                        judge.setCode(null);
                    }
                } else { // 不是登陆状态，就直接无权限查看代码
                    judge.setCode(null);
                }
            }
            // 比赛外的提交代码 如果不是超管或题目管理员，需要检查网站是否开启隐藏代码功能
            if(!isRoot && isProblemAdmin && judge.getCode() != null) {
                try {
                    accessValidator.validateAccess(LOJAccessEnum.HIDE_NON_CONTEST_SUBMISSION_CODE);
                } catch (AccessException e) {
                    judge.setCode("Because the super administrator has enabled " +
                            "the function of not viewing the submitted code outside the contest of master station, \n" +
                            "the code of this submission details has been hidden.");
                }
            }
        }

        Problem problem = problemEntityService.getById(judge.getPid());

        // 只允许用户查看ce错误,sf错误，se错误信息提示
        if(judge.getStatus().intValue() != Constants.Judge.STATUS_COMPILE_ERROR.getStatus() &&
                judge.getStatus().intValue() != Constants.Judge.STATUS_SYSTEM_ERROR.getStatus() &&
                judge.getStatus().intValue() != Constants.Judge.STATUS_SUBMITTED_FAILED.getStatus()) {
            judge.setErrorMessage("The error message does not support viewing.");
        }
        submissionInfoVO.setSubmission(judge);
        submissionInfoVO.setCodeShare(problem.getCodeShare());
        return submissionInfoVO;
    }

    /**
     * 获得指定提交id的测试样例结果，暂不支持查看测试数据，只可看测试点结果，时间，空间，或者IO得分
     * @param submitId
     * @return
     */
    public JudgeCaseVO getALLCaseResult(Long submitId) throws StatusNotFoundException, StatusForbiddenException {

        Judge judge = judgeEntityService.getById(submitId);

        if(judge == null) {
            throw new StatusNotFoundException("此提交数据不存在！");
        }

        Problem problem = problemEntityService.getById(judge.getPid());

        // 如果该题不支持开放测试点结果查看
        if(!problem.getOpenCaseResult()) {
            return null;
        }

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        QueryWrapper<JudgeCase> wrapper = new QueryWrapper<>();
        if(judge.getCid() == 0) { // 非比赛提交
            if(userRolesVo == null) { // 没有登录
                wrapper.select("time", "memory", "score", "status", "user_output","group_num", "seq", "mode");
            } else {
                boolean isRoot = SecurityUtils.getSubject().hasRole("root"); // 是否为超级管理员
                if(!isRoot
                        && !SecurityUtils.getSubject().hasRole("admin")
                        && !SecurityUtils.getSubject().hasRole("problem_admin")) {
                    wrapper.select("time", "memory", "score", "status", "user_output","group_num", "seq", "mode");
                }
            }
        } else { // 比赛提交
            if(userRolesVo == null) {
                throw new StatusForbiddenException("您还未登录！不可查看比赛提交的测试点详情！");
            }
            boolean isRoot = SecurityUtils.getSubject().hasRole("root");  // 是否为超级管理员
            if(!isRoot) {
                Contest contest = contestEntityService.getById(judge.getCid());
                // 如果不是比赛管理员 需要受到规则限制
                if(!contest.getUid().equals(userRolesVo.getUid()) ||
                        (contest.getIsGroup() && !groupValidator.isGroupRoot(userRolesVo.getUid(), contest.getGid()))) {
                    // ACM比赛期间强制禁止查看,比赛管理员除外（赛后恢复正常）

                    if(contest.getType().intValue() == Constants.Contest.TYPE_ACM.getCode()) {
                        if(contest.getStatus().intValue() == Constants.Contest.STATUS_RUNNING.getCode()) {
                            return null;
                        }
                    } else {
                        // 当前是oi比赛期间 同时处于封榜时间
                        if(contest.getSealRank() && contest.getStatus().intValue() == Constants.Contest.STATUS_RUNNING.getCode()
                                && contest.getSealRankTime().before(new Date())) {
                            return  null;
                        }
                    }
                    wrapper.select("time", "memory", "score", "status", "user_output", "group_num", "seq", "mode");
                }
            }
        }

        wrapper.eq("submit_id", submitId);
        if(!problem.getIsRemote()) {
            wrapper.last("order by seq asc");
        }
        // 当前所有测试点只支持 空间 时间 状态码 IO得分 和错误信息提示查看而已
        List<JudgeCase> judgeCaseList = judgeCaseEntityService.list(wrapper);
        JudgeCaseVO judgeCaseVO = new JudgeCaseVO();
        if(!CollectionUtils.isEmpty(judgeCaseList)) {
            String mode = judgeCaseList.get(0).getMode();
            Constants.JudgeCaseMode judgeCaseMode = Constants.JudgeCaseMode.getJudgeCaseMode(mode);
            switch (judgeCaseMode) {
                case DEFAULT:
                case ERGODIC_WITHOUT_ERROR:
                    judgeCaseVO.setJudgeCaseList(judgeCaseList);
                    break;
                case SUBTASK_AVERAGE:
                case SUBTASK_LOWEST:
                    judgeCaseVO.setSubTaskJudgeCaseVoList(buildSubTaskDetail(judgeCaseList, judgeCaseMode));
                    break;
            }
            judgeCaseVO.setJudgeCaseMode(judgeCaseMode.getMode());
        } else {
            judgeCaseVO.setJudgeCaseList(judgeCaseList);
            judgeCaseVO.setJudgeCaseMode(Constants.JudgeCaseMode.DEFAULT.getMode());
        }
        return judgeCaseVO;
    }

    private List<SubTaskJudgeCaseVO> buildSubTaskDetail(List<JudgeCase> judgeCaseList, Constants.JudgeCaseMode judgeCaseMode) {
        List<SubTaskJudgeCaseVO> subTaskJudgeCaseVOS = new ArrayList<>();
        LinkedHashMap<Integer,  List<JudgeCase>> groupJudgeCaseMap = judgeCaseList.stream()
                .sorted(Comparator.comparingInt(JudgeCase::getGroupNum).thenComparingInt(JudgeCase::getSeq))
                .collect(Collectors.groupingBy(JudgeCase::getGroupNum,LinkedHashMap::new, Collectors.toList()));

        if(judgeCaseMode == Constants.JudgeCaseMode.SUBTASK_AVERAGE) {
            for (Map.Entry<Integer, List<JudgeCase>> entry: groupJudgeCaseMap.entrySet()) {
                int sumScore = 0;
                boolean hasNotACJudgeCase = false;
                int acCount = 0;
                for(JudgeCase judgeCase: entry.getValue()) {
                    sumScore += judgeCase.getScore();
                    if(!Objects.equals(Constants.Judge.STATUS_ACCEPTED.getStatus(), judgeCase.getStatus())) {
                        hasNotACJudgeCase = true;
                    } else {
                        acCount ++;
                    }
                }
                SubTaskJudgeCaseVO subTaskJudgeCaseVO = new SubTaskJudgeCaseVO();
                subTaskJudgeCaseVO.setGroupName(entry.getKey());
                subTaskJudgeCaseVO.setSubtaskDetailList(entry.getValue());
                subTaskJudgeCaseVO.setAc(acCount);
                subTaskJudgeCaseVO.setTotal(entry.getValue().size());
                int score = (int) Math.round(sumScore * 1.0 / entry.getValue().size());
                subTaskJudgeCaseVO.setScore(score);
                if(hasNotACJudgeCase) {
                    if(score == 0) {
                        subTaskJudgeCaseVO.setStatus(Constants.Judge.STATUS_WRONG_ANSWER.getStatus());
                    } else {
                        subTaskJudgeCaseVO.setStatus(Constants.Judge.STATUS_PARTIAL_ACCEPTED.getStatus());
                    }
                } else {
                    subTaskJudgeCaseVO.setStatus(Constants.Judge.STATUS_ACCEPTED.getStatus());
                }
                subTaskJudgeCaseVOS.add(subTaskJudgeCaseVO);
            }
        } else {

            for (Map.Entry<Integer, List<JudgeCase>> entry: groupJudgeCaseMap.entrySet()) {
                int minScore = 2147483647;
                JudgeCase finalResJudgeCase = null;
                int acCount = 0;
                for (JudgeCase judgeCase: entry.getValue()) {
                    if(!Constants.Judge.STATUS_CANCELLED.getStatus().equals(judgeCase.getStatus())) {
                        if(judgeCase.getScore() < minScore) {
                            finalResJudgeCase = judgeCase;
                            minScore = judgeCase.getScore();
                        }
                        if(Objects.equals(Constants.Judge.STATUS_ACCEPTED.getStatus(), judgeCase.getStatus())) {
                            acCount ++;
                        }
                    }
                }

                SubTaskJudgeCaseVO subTaskJudgeCaseVO = new SubTaskJudgeCaseVO();
                subTaskJudgeCaseVO.setGroupName(entry.getKey());
                subTaskJudgeCaseVO.setAc(acCount);
                subTaskJudgeCaseVO.setTotal(entry.getValue().size());

                if(finalResJudgeCase != null) {
                    subTaskJudgeCaseVO.setMemory(finalResJudgeCase.getMemory());
                    subTaskJudgeCaseVO.setScore(finalResJudgeCase.getScore());
                    subTaskJudgeCaseVO.setTime(finalResJudgeCase.getTime());
                    subTaskJudgeCaseVO.setStatus(finalResJudgeCase.getStatus());
                }
            }
        }
        return subTaskJudgeCaseVOS;
    }

    public IPage<JudgeVO> getJudgeList(Integer limit,
                                       Integer currentPage,
                                       Boolean onlyMine,
                                       String searchPid,
                                       Integer searchStatus,
                                       String searchUsername,
                                       Boolean completeProblemID,
                                       Long gid) throws StatusAccessDeniedException {
        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) { currentPage = 1;}
        if(limit == null || limit < 1) {
            limit = 30;
        }

        String uid = null;

        // 只查看当前用户的提交
        if(onlyMine) {
            // 需要获取一下该token对应用户的数据（有token便能获取到）

            AccountProfile userRoleVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

            if(userRoleVo == null) {
                throw new StatusAccessDeniedException("当前用户数据为空，请您重新登陆！");
            }
            uid = userRoleVo.getUid();
        }
        if(searchPid != null) {
            searchPid = searchPid.trim();
        }
        if(searchUsername != null) {
            searchUsername = searchUsername.trim();
        }

        return judgeEntityService.getCommonJudgeList(limit,
                currentPage,
                searchPid,
                searchStatus,
                searchUsername,
                uid,
                completeProblemID,
                gid);
    }

    public void updateSubmission(Judge judge) throws StatusFailException, StatusForbiddenException {
        if(judge == null || judge.getSubmitId() == null || judge.getShare() == null) {
            throw new StatusFailException("修改失败，请求参数错误！");
        }

        QueryWrapper<Judge> judgeQueryWrapper = new QueryWrapper<>();
        judgeQueryWrapper.select("submit_id", "cid", "uid")
                .eq("submit_id", judge.getSubmitId());

        Judge judgeInfo = judgeEntityService.getOne(judgeQueryWrapper);

        // 需要获取一下该token对应用户的数据
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        if(!userRolesVo.getUid().equals(judgeInfo.getUid())) { // 判断该提交是否为当前用户的
            throw new StatusForbiddenException("对不起，您不能修改他人的代码分享权限！");
        }

        if(judgeInfo.getCid() != 0) {// 如果是比赛提交，不可分享！
            throw new StatusForbiddenException("对不起，您不能分享比赛题目的提交代码！");
        }

        UpdateWrapper<Judge> judgeUpdateWrapper = new UpdateWrapper<>();
        judgeUpdateWrapper.set("share", judge.getShare())
                .eq("submit_id", judge.getSubmitId());

        boolean isOk = judgeEntityService.update(judgeUpdateWrapper);
        if(!isOk) {
            throw new StatusFailException("修改代码权限失败！");
        }
    }

    public HashMap<Long,Object> checkCommonJudgeResult(SubmitIdListDTO submitIdListDTO) {

        List<Long> submitIds = submitIdListDTO.getSubmitIds();

        if(CollectionUtils.isEmpty(submitIds)) {
            return new HashMap<>();
        }

        QueryWrapper<Judge> queryWrapper = new QueryWrapper<>();
        // lambada表达式过滤掉code
        queryWrapper.select(Judge.class, info ->!info.getColumn().equals("code")).in("submit_id", submitIds);
        List<Judge> judgeList = judgeEntityService.list(queryWrapper);
        HashMap<Long,Object> result = new HashMap<>();
        for(Judge judge: judgeList) {
            judge.setCode(null);
            judge.setErrorMessage(null);
            judge.setVjudgeSubmitId(null);
            judge.setVjudgeUsername(null);
            judge.setVjudgePassword(null);
            result.put(judge.getSubmitId(), judge);
        }
        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    public Judge resubmit(Long submitId) throws StatusNotFoundException {

        Judge judge = judgeEntityService.getById(submitId);
        if(judge == null) {
            throw new StatusNotFoundException("此提交数据不存在！");
        }

        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
        problemQueryWrapper.select("id", "is_remote", "problem_id")
                .eq("id",judge.getPid());
        Problem problem = problemEntityService.getOne(problemQueryWrapper);

        // 如果是非比赛题目
        if(judge.getCid() == 0) {
            // 重判前，需要将该题目对应记录表一并更新
            // 如果该题已经是AC通过状态，更新该题目的用户ac做题表 user_acproblem
            if(judge.getStatus().intValue() == Constants.Judge.STATUS_ACCEPTED.getStatus().intValue()) {
                QueryWrapper<UserAcproblem> userAcproblemQueryWrapper = new QueryWrapper<>();
                userAcproblemQueryWrapper.eq("submit_id", judge.getSubmitId());
                userAcproblemEntityService.remove(userAcproblemQueryWrapper);
            }
        } else {
            if(problem.getIsRemote()) {
                // 将对应比赛记录设置成默认值
                UpdateWrapper<ContestRecord> updateWrapper = new UpdateWrapper<>();
                updateWrapper.eq("submit_id", submitId).setSql("status=null,score=null");
                contestRecordEntityService.update(updateWrapper);
            } else {
                throw new StatusNotFoundException("错误！非vJudge题目在比赛过程无权限重新提交");
            }
        }

        boolean isHasSubmitIdRemoteRejudge = false;
        if(Objects.nonNull(judge.getVjudgeSubmitId()) &&
                (judge.getStatus().intValue() == Constants.Judge.STATUS_SUBMITTED_FAILED.getStatus()
                    || judge.getStatus().intValue() == Constants.Judge.STATUS_PENDING.getStatus()
                    || judge.getStatus().intValue() == Constants.Judge.STATUS_JUDGING.getStatus()
                    || judge.getStatus().intValue() == Constants.Judge.STATUS_COMPILING.getStatus()
                    || judge.getStatus().intValue() == Constants.Judge.STATUS_SYSTEM_ERROR.getStatus())) {
            isHasSubmitIdRemoteRejudge = true;
        }

        // 重新进入等待队列
        judge.setStatus(Constants.Judge.STATUS_PENDING.getStatus());
        judge.setVersion(judge.getVersion() + 1);
        judge.setErrorMessage(null)
                .setOiRankScore(null)
                .setScore(null)
                .setTime(null)
                .setJudger("")
                .setMemory(null);
        judgeEntityService.updateById(judge);

        // 将提交加入任务队列
        if(problem.getIsRemote()) {  // 如果是远程oj判题
            remoteJudgeDispatcher.sendTask(judge.getSubmitId(),
                    judge.getPid(),
                    problem.getProblemId(),
                    judge.getCid() != 0,
                    isHasSubmitIdRemoteRejudge);
        } else {
            judgeDispatcher.sendTask(judge.getSubmitId(),
                    judge.getPid(),
                    judge.getCid() != 0);
        }
        return judge;
    }
}
