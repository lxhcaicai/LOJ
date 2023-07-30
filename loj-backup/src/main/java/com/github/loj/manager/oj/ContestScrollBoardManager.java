package com.github.loj.manager.oj;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestProblemEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ContestScrollBoardInfoVO;
import com.github.loj.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Component
public class ContestScrollBoardManager {


    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private ContestProblemEntityService contestProblemEntityService;

    @Autowired
    private ProblemEntityService problemEntityService;

    public ContestScrollBoardInfoVO getContestScrollBoardInfo(Long cid) throws StatusFailException {
        Contest contest = contestEntityService.getById(cid);

        if(contest == null) {
            throw new StatusFailException("比赛不存在 (The contest does not exist)");
        }

        if(!Objects.equals(contest.getType(), Constants.Contest.TYPE_ACM.getCode())) {
            throw new StatusFailException("非ACM赛制的比赛无法进行滚榜  (Non - ACM contest board cannot be rolled)");
        }

        if(!contest.getSealRank()) {
            throw new StatusFailException("比赛未开启封榜，无法进行滚榜 (The contest has not been closed, and cannot roll)");
        }

        if(!Objects.equals(contest.getStatus(), Constants.Contest.STATUS_ENDED.getCode())) {
            throw new StatusFailException("比赛未结束，禁止进行滚榜 (Roll off is prohibited before the contest is over)");
        }

        QueryWrapper<ContestProblem> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("cid", cid);
        List<ContestProblem> contestProblemList = contestProblemEntityService.list(queryWrapper);

        List<Long> pidList = contestProblemList.stream().map(ContestProblem::getPid).collect(Collectors.toList());
        if(!CollectionUtils.isEmpty(pidList)) {
            QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
            problemQueryWrapper.select("id","auth")
                    .ne("auth", 2)
                    .in("id", pidList);
            List<Problem> problemList = problemEntityService.list(problemQueryWrapper);
            List<Long> idList = problemList.stream().map(Problem::getId).collect(Collectors.toList());
            contestProblemList = contestProblemList.stream()
                    .filter(p -> idList.contains(p.getPid()))
                    .collect(Collectors.toList());
        }

        HashMap<String,String> balloonColor = new HashMap<>();
        for(ContestProblem contestProblem: contestProblemList) {
            balloonColor.put(contestProblem.getDisplayId(), contestProblem.getColor());
        }

        ContestScrollBoardInfoVO info = new ContestScrollBoardInfoVO();
        info.setId(cid);
        info.setProblemCount(contestProblemList.size());
        info.setBalloonColor(balloonColor);
        info.setRankShowName(contest.getRankShowName());
        info.setStartTime(contest.getStartTime());
        info.setSealRankTime(contest.getSealRankTime());

        return info;
    }

}
