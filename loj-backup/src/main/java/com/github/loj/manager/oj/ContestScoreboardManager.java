package com.github.loj.manager.oj;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestProblemEntityService;
import com.github.loj.pojo.dto.ContestRankDTO;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.pojo.vo.ContestOutsideInfoVO;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.ContestValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Component
public class ContestScoreboardManager {

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private ContestValidator contestValidator;

    @Autowired
    private ContestRankManager contestRankManager;

    @Autowired
    private ContestProblemEntityService contestProblemEntityService;

    public IPage getContestOutsideScoreboard(ContestRankDTO contestRankDTO) throws StatusFailException, StatusForbiddenException {

        Long cid = contestRankDTO.getCid();
        List<String> concernedList = contestRankDTO.getConcernedList();
        Boolean removeStar = contestRankDTO.getRemoveStar();
        Boolean forceRefresh = contestRankDTO.getForceRefresh();

        if(cid == null ){
            throw new StatusFailException("错误：比赛id不能为空");
        }
        if(removeStar == null) {
            removeStar = false;
        }
        if(forceRefresh == null) {
            forceRefresh = false;
        }
        // 获取本场比赛的状态
        Contest contest = contestEntityService.getById(cid);

        if(contest == null) {
            throw new StatusFailException("访问错误：该比赛不存在！");
        }

        if(!contest.getOpenRank()) {
            throw new StatusForbiddenException("本场比赛未开启外榜，禁止访问外榜！");
        }

        if(contest.getStatus().equals(Constants.Contest.STATUS_SCHEDULED.getCode())) {
            throw new StatusForbiddenException("本场比赛正在筹备中，禁止访问外榜！");
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 超级管理员或者该比赛的创建者，则为比赛管理者
        boolean isRoot = false;
        String currentUid= null;

        if(userRolesVo != null) {
            currentUid = userRolesVo.getUid();
            isRoot = SecurityUtils.getSubject().hasRole("root");
            // 不是比赛创建者或者超管无权限开启强制实时榜单
            if(!isRoot && !contest.getUid().equals(currentUid)) {
                forceRefresh = false;
            }
        }

        Integer currentPage = contestRankDTO.getCurrentPage();
        Integer limit = contestRankDTO.getLimit();
        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 50;
        }

        // 校验该比赛是否开启了封榜模式，超级管理员和比赛创建者可以直接看到实际榜单
        boolean isOpenSealRank = contestValidator.isSealRank(currentUid,contest,forceRefresh, isRoot);

        if(contest.getType().intValue() == Constants.Contest.TYPE_ACM.getCode()) {
            // 获取ACM比赛排行榜外榜
            return contestRankManager.getACMContestScoreboard(isOpenSealRank,
                    removeStar,
                    contest,
                    null,
                    concernedList,
                    contestRankDTO.getExternalCidList(),
                    currentPage,
                    limit,
                    contestRankDTO.getKeyword(),
                    !forceRefresh,
                    15L);
        } else {
            // 获取OI比赛排行榜外榜
            return contestRankManager.getOIContestScoreboard(isOpenSealRank,
                    removeStar,
                    contest,
                    null,
                    concernedList,
                    contestRankDTO.getExternalCidList(),
                    currentPage,
                    limit,
                    contestRankDTO.getKeyword(),
                    !forceRefresh,
                    15L);
        }
    }

    public ContestOutsideInfoVO getContestOutsideInfo(Long cid) throws StatusNotFoundException, StatusForbiddenException {
        ContestVO  contestInfo = contestEntityService.getContestInfoById(cid);

        if(contestInfo == null) {
            throw new StatusNotFoundException("访问错误：该比赛不存在！");
        }

        if(!contestInfo.getOpenRank()) {
            throw new StatusForbiddenException("本场比赛未开启外榜，禁止访问外榜！");
        }
        // 获取本场比赛的状态
        if(contestInfo.getStatus().equals(Constants.Contest.STATUS_SCHEDULED.getCode())) {
            throw new StatusForbiddenException("本场比赛正在筹备中，禁止访问外榜！");
        }

        contestInfo.setNow(new Date());
        ContestOutsideInfoVO contestOutsideInfoVO = new ContestOutsideInfoVO();
        contestOutsideInfoVO.setContest(contestInfo);

        QueryWrapper<ContestProblem> contestProblemQueryWrapper = new QueryWrapper<>();
        contestProblemQueryWrapper.eq("cid", cid).orderByAsc("display_id");
        List<ContestProblem> contestProblemList = contestProblemEntityService.list(contestProblemQueryWrapper);
        contestOutsideInfoVO.setProblemList(contestProblemList);

        return contestOutsideInfoVO;
    }
}
