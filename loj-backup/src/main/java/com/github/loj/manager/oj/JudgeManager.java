package com.github.loj.manager.oj;

import cn.hutool.core.util.IdUtil;
import cn.hutool.json.JSONUtil;
import com.github.loj.annotation.LOJAccessEnum;
import com.github.loj.common.exception.*;
import com.github.loj.config.NacosSwitchConfig;
import com.github.loj.config.SwitchConfig;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.judge.self.JudgeDispatcher;
import com.github.loj.pojo.dto.SubmitJudgeDTO;
import com.github.loj.pojo.dto.TestJudgeDTO;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.SubmissionInfoVO;
import com.github.loj.pojo.vo.TestJudgeVO;
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
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.rmi.AccessException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/5/6 22:09
 */
@Component
public class JudgeManager {


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

    public Judge submitProblemJudge(SubmitJudgeDTO judgeDTO) throws AccessException, StatusFailException, StatusForbiddenException {
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
            // TODO
        } else if(isTrainingSubmission) {
            // TODO
        } else {
            beforeDispatchInitManager.initCommonSubmission(judgeDTO.getPid(), judgeDTO.getGid(), judge);
        }

        // 将提交加入任务队列
        if(judgeDTO.getIsRemote()) { // 如果是远程oj判题
            // TODO
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
}
