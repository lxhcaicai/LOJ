package com.github.loj.manager.oj;

import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestProblemEntityService;
import com.github.loj.dao.contest.ContestRecordEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.ContestValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/7 17:38
 */
@Component
public class BeforeDispatchInitManager {

    @Resource
    private ContestEntityService contestEntityService;

    @Resource
    ContestRecordEntityService contestRecordEntityService;

    @Resource
    private ContestProblemEntityService contestProblemEntityService;

    @Resource
    private ProblemEntityService problemEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private JudgeEntityService judgeEntityService;

    @Resource
    private TrainingManager trainingManager;

    @Resource
    private ContestValidator contestValidator;


    public void initCommonSubmission(String problemId, Long gid, Judge judge) throws StatusForbiddenException {

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
        problemQueryWrapper.select("id", "problem_id", "auth", "is_group", "gid");
        problemQueryWrapper.eq("problem_id", problemId);
        Problem problem = problemEntityService.getOne(problemQueryWrapper, false);

        if(problem == null) {
            throw new StatusForbiddenException("错误！当前题目已不存在，不可提交！");
        }

        if(problem.getAuth() == 2) {
            throw new StatusForbiddenException("错误！当前题目不可提交！");
        }

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        if(problem.getIsGroup()) {
            if(gid == null) {
                throw new StatusForbiddenException("提交失败，该题目为团队所属，请你前往指定团队内提交！");
            }
            if(!isRoot && !groupValidator.isGroupMember(userRolesVo.getUid(), problem.getGid())) {
                throw new StatusForbiddenException("对不起，您并非该题目所属的团队内成员，无权进行提交！");
            }
            judge.setGid(problem.getGid());
        }

        judge.setCpid(0L)
                .setPid(problem.getId())
                .setDisplayPid(problem.getProblemId());

        // 将新提交数据插入数据库
        judgeEntityService.save(judge);

        trainingManager.checkAndSyncTrainingRecord(problem.getId(), judge.getSubmitId(), judge.getUid());

    }

    @Transactional(rollbackFor = Exception.class)
    public void initContestSubmission(Long cid, String displayId, AccountProfile userRolesVo, Judge judge) throws StatusForbiddenException {

        // 首先判断一下比赛的状态是否是正在进行，结束状态都不能提交，比赛前比赛管理员可以提交
        Contest contest = contestEntityService.getById(cid);

        if(contest == null) {
            throw  new StatusForbiddenException("对不起，该比赛不存在！");
        }

        if(contest.getStatus().intValue() == Constants.Contest.STATUS_ENDED.getCode()) {
            throw new StatusForbiddenException("比赛已结束，不可再提交！");
        }

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        if(!isRoot && !contest.getUid().equals(userRolesVo.getUid())
                && !(contest.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), contest.getGid()))) {

            if(contest.getStatus().intValue() == Constants.Contest.STATUS_SCHEDULED.getCode()) {
                throw new StatusForbiddenException("比赛未开始，不可提交！");
            }
            // 需要检查是否有权限在当前比赛进行提交
            contestValidator.validateJudgeAuth(contest, userRolesVo.getUid());

            // 需要校验当前比赛是否为保护或私有比赛，同时是否开启账号规则限制，如果有，需要对当前用户的用户名进行验证
            if(contest.getOpenAccountLimit()
                    && !contestValidator.validateAccountRule(contest.getAccountLimitRule(), userRolesVo.getUsername())) {
                throw new StatusForbiddenException("对不起！本次比赛只允许符合特定账号规则的用户参赛！");
            }
        }

        // 查询获取对应的pid和cpid
        QueryWrapper<ContestProblem> contestProblemQueryWrapper = new QueryWrapper<>();
        contestProblemQueryWrapper.eq("cid",cid).eq("display_id", displayId);
        ContestProblem contestProblem = contestProblemEntityService.getOne(contestProblemQueryWrapper,false);
        judge.setCpid(contestProblem.getId())
                .setPid(contestProblem.getPid())
                .setGid(contest.getGid());

        Problem problem = problemEntityService.getById(contestProblem.getPid());

        if(problem == null) {
            throw new StatusForbiddenException("错误！当前题目已不存在，不可提交！");
        }

        if(problem.getAuth() == 2) {
            throw new StatusForbiddenException("错误！当前题目已被隐藏，不可提交！");
        }

        if(problem.getIsGroup()) {
            judge.setGid(problem.getGid());
        }

        judge.setDisplayPid(problem.getProblemId());
        // 将新提交数据插入数据库
        judgeEntityService.save(judge);

        // 同时初始化写入contest_record表
        ContestRecord contestRecord = new ContestRecord();
        contestRecord.setDisplayId(displayId)
                .setCpid(contestProblem.getId())
                .setSubmitId(judge.getSubmitId())
                .setPid(judge.getPid())
                .setUsername(userRolesVo.getUsername())
                .setRealname(userRolesVo.getRealname())
                .setUid(userRolesVo.getUid())
                .setCid(judge.getCid())
                .setSubmitId(judge.getSubmitId());

        if(contest.getStatus().intValue() == Constants.Contest.STATUS_SCHEDULED.getCode()) {
            contestRecord.setTime(0L);
        } else {
            contestRecord.setTime(DateUtil.between(contest.getStartTime(), judge.getSubmitTime(), DateUnit.SECOND));
        }
        contestRecordEntityService.save(contestRecord);
    }

}
