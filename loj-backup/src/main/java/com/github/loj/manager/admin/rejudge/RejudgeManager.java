package com.github.loj.manager.admin.rejudge;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.contest.ContestRecordEntityService;
import com.github.loj.dao.judge.JudgeCaseEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.user.UserAcproblemEntityService;
import com.github.loj.judge.remote.RemoteJudgeDispatcher;
import com.github.loj.judge.self.JudgeDispatcher;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.judge.JudgeCase;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.user.UserAcproblem;
import com.github.loj.utils.Constants;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Component
public class RejudgeManager {

    @Resource
    private JudgeEntityService judgeEntityService;

    @Resource
    private ProblemEntityService problemEntityService;

    @Resource
    private UserAcproblemEntityService userAcproblemEntityService;

    @Resource
    private ContestRecordEntityService contestRecordEntityService;

    @Resource
    private JudgeCaseEntityService judgeCaseEntityService;

    @Resource
    private RemoteJudgeDispatcher remoteJudgeDispatcher;

    @Resource
    private JudgeDispatcher judgeDispatcher;

    public Judge rejudge(Long submitId) throws StatusFailException {
        Judge judge = judgeEntityService.getById(submitId);

        boolean isContestSubmission = judge.getCid() != 0;

        boolean hasSubmitIdRemoteRejudge = checkAndUpdateJudge(isContestSubmission, judge, submitId);
        // 调用判题服务
        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
        problemQueryWrapper.select("id","is_remote","problem_id")
                .eq("id", judge.getPid());
        Problem problem = problemEntityService.getOne(problemQueryWrapper);
        if (problem.getIsRemote()) {
            remoteJudgeDispatcher.sendTask(judge.getSubmitId(), judge.getPid(), problem.getProblemId(),
                    isContestSubmission, hasSubmitIdRemoteRejudge);
        } else {
            judgeDispatcher.sendTask(judge.getSubmitId(), judge.getPid(), isContestSubmission);
        }
        return judge;
    }

    @Transactional(rollbackFor = Exception.class)
    public boolean checkAndUpdateJudge(Boolean isContestSubmission, Judge judge, Long submitId) throws StatusFailException {
        // 如果是非比赛题目
        boolean resetContestRecordResult = true;
        if(!isContestSubmission) {
            // 重判前，需要将该题目对应记录表一并更新
            // 如果该题已经是AC通过状态，更新该题目的用户ac做题表 user_acproblem
            if(judge.getStatus().intValue() == Constants.Judge.STATUS_ACCEPTED.getStatus().intValue()) {
                QueryWrapper<UserAcproblem> userAcproblemQueryWrapper = new QueryWrapper<>();
                userAcproblemQueryWrapper.eq("submit_id", judge.getSubmitId());
                userAcproblemEntityService.remove(userAcproblemQueryWrapper);
            }
        } else {
            // 将对应比赛记录设置成默认值
            UpdateWrapper<ContestRecord> updateWrapper = new UpdateWrapper<>();
            updateWrapper.eq("submit_id", submitId).setSql("status=null,score=null");
            resetContestRecordResult = contestRecordEntityService.update(updateWrapper);
        }
        // 清除该提交对应的测试点结果
        QueryWrapper<JudgeCase> judgeCaseQueryWrapper = new QueryWrapper<>();
        judgeCaseQueryWrapper.eq("submit_id",submitId);
        judgeCaseEntityService.remove(judgeCaseQueryWrapper);

        boolean hasSubmitIdRemoteRejudge = isHasSubmitIdRemoteRejudge(judge.getVjudgeSubmitId(), judge.getStatus());

        // 设置默认值
        judge.setStatus(Constants.Judge.STATUS_PENDING.getStatus()); // 开始进入判题队列
        judge.setVersion(judge.getVersion() + 1);
        judge.setJudger("")
                .setIsManual(false)
                .setTime(null)
                .setMemory(null)
                .setErrorMessage(null)
                .setOiRankScore(null)
                .setScore(null);

        boolean isUpdateJudgeOk = judgeEntityService.updateById(judge);

        if (!resetContestRecordResult || !isUpdateJudgeOk) {
            throw new StatusFailException("重判失败！请重新尝试！");
        }
        return hasSubmitIdRemoteRejudge;
    }

    private boolean isHasSubmitIdRemoteRejudge(Long vjudgeSubmitId, int status) {
        boolean isHasSubmitIdRemoteRejudge = false;
        if (vjudgeSubmitId != null &&
                (status == Constants.Judge.STATUS_SUBMITTED_FAILED.getStatus()
                        || status == Constants.Judge.STATUS_COMPILING.getStatus()
                        || status == Constants.Judge.STATUS_PENDING.getStatus()
                        || status == Constants.Judge.STATUS_JUDGING.getStatus()
                        || status == Constants.Judge.STATUS_SYSTEM_ERROR.getStatus())) {
            isHasSubmitIdRemoteRejudge = true;
        }
        return isHasSubmitIdRemoteRejudge;
    }
}
