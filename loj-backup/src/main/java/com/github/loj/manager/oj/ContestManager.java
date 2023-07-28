package com.github.loj.manager.oj;

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.common.AnnouncementEntityService;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestProblemEntityService;
import com.github.loj.dao.contest.ContestRegisterEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.pojo.bo.Pair_;
import com.github.loj.pojo.dto.ContestRankDTO;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestRegister;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.vo.*;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.ContestValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/17 23:01
 */
@Component
public class ContestManager {

    @Autowired
    private ContestRankManager contestRankManager;

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private JudgeEntityService judgeEntityService;

    @Autowired
    private AnnouncementEntityService announcementEntityService;

    @Autowired
    private ContestValidator contestValidator;

    @Autowired
    private ContestProblemEntityService contestProblemEntityService;

    @Autowired
    private ContestRegisterEntityService contestRegisterEntityService;

    public IPage<ContestVO> getContestList(Integer limit, Integer currentPage, Integer status, Integer type, String keyword) {
        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return contestEntityService.getContestList(limit, currentPage, type, status, keyword);
    }

    public ContestVO getContestInfo(Long cid) throws StatusFailException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        ContestVO contestInfo = contestEntityService.getContestInfoById(cid);
        if(contestInfo == null) {
            throw new StatusFailException("对不起，该比赛不存在!");
        }

        Contest contest = contestEntityService.getById(cid);
        if(contest.getIsGroup()) {
            if(!groupValidator.isGroupMember(userRolesVo.getUid(), contest.getGid()) && !isRoot) {
                throw new StatusForbiddenException("对不起，您无权限操作！");
            }
        }

        // 设置当前服务器系统时间
        contestInfo.setNow(new Date());
        return  contestInfo;
    }

    public IPage<JudgeVO> getContestSubmissionList(Integer limit,
                                                   Integer currentPage,
                                                   boolean onlyMine,
                                                   String displayId,
                                                   Integer searchStatus,
                                                   String searchUsername,
                                                   Long searchCid,
                                                   boolean beforeContestSubmit,
                                                   boolean completeProblemID) throws StatusForbiddenException, StatusFailException {

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        // 获取本场比赛的状态
        Contest contest = contestEntityService.getById(searchCid);

        // 是否为超级管理员或者该比赛的创建者，则为比赛管理者
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        // 需要对该比赛做判断，是否处于开始或结束状态才可以获取题目，同时若是私有赛需要判断是否已注册（比赛管理员包括超级管理员可以直接获取）
        contestValidator.validateContestAuth(contest, userRolesVo, isRoot);

        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 30;
        }

        String uid = null;
        // 只查看当前用户的提交
        if(onlyMine) {
            // 需要获取一下该token对应用户的数据（有token便能获取到）
            uid = userRolesVo.getUid();
        }

        String rule;
        if(contest.getType().intValue() == Constants.Contest.TYPE_ACM.getCode()) {
            rule = Constants.Contest.TYPE_ACM.getName();
        } else {
            rule = Constants.Contest.TYPE_OI.getName();
        }

        Date sealRankTime = null;

        // 需要判断是否需要封榜
        if(contestValidator.isSealRank(userRolesVo.getUid(), contest, true, isRoot)) {
            sealRankTime = contest.getSealRankTime();
        }
        // OI比赛封榜期间不更新，ACM比赛封榜期间可看到自己的提交，但是其它人的不可见
        IPage<JudgeVO> contestJudgeList = judgeEntityService.getContestJudgeList(limit,
                currentPage,
                displayId,
                searchCid,
                searchStatus,
                searchUsername,
                uid,beforeContestSubmit,
                rule,
                contest.getStartTime(),
                sealRankTime,
                userRolesVo.getUid(),
                completeProblemID);

        if(contestJudgeList.getTotal() == 0) { // 未查询到一条数据
            return contestJudgeList;
        } else {
            // 比赛还是进行阶段，同时不是超级管理员与比赛管理员，需要将除自己之外的提交的时间、空间、长度隐藏
            if(contest.getStatus().intValue() == Constants.Contest.STATUS_RUNNING.getCode()
                    && !isRoot && !userRolesVo.getUid().equals(contest.getUid())) {
                contestJudgeList.getRecords().forEach(judgeVo -> {
                    if(!judgeVo.getUid().equals(userRolesVo.getUid())) {
                        judgeVo.setTime(null);
                        judgeVo.setMemory(null);
                        judgeVo.setLength(null);
                    }
                });
            }
            return contestJudgeList;
        }
    }

    public IPage getContestRank(ContestRankDTO contestRankDTO) throws StatusFailException, StatusForbiddenException {
        Long cid = contestRankDTO.getCid();
        List<String> concernedList = contestRankDTO.getConcernedList();
        Integer currentPage = contestRankDTO.getCurrentPage();
        Integer limit = contestRankDTO.getLimit();
        Boolean removeStar = contestRankDTO.getRemoveStar();
        Boolean forceRefresh = contestRankDTO.getForceRefresh();

        if(cid == null) {
            throw new StatusFailException("错误：cid不能为空");
        }

        if(removeStar == null) {
            removeStar = false;
        }
        if(forceRefresh == null) {
            forceRefresh = false;
        }
        // 页数，每页题数若为空，设置默认值
        if(currentPage == null|| currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 50;
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        // 获取本场比赛的状态
        Contest contest = contestEntityService.getById(contestRankDTO.getCid());

        // 超级管理员或者该比赛的创建者，则为比赛管理者
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        // 需要对该比赛做判断，是否处于开始或结束状态才可以获取题目，同时若是私有赛需要判断是否已注册（比赛管理员包括超级管理员可以直接获取）
        contestValidator.validateContestAuth(contest, userRolesVo, isRoot);

        // 校验该比赛是否开启了封榜模式，超级管理员和比赛创建者可以直接看到实际榜单
        boolean isOpenSealRank = contestValidator.isSealRank(userRolesVo.getUid(), contest, forceRefresh, isRoot);

        IPage resultList = null;
        if(contest.getType().intValue() == Constants.Contest.TYPE_ACM.getCode()) {
            // ACM比赛
            // 进行排行榜计算以及排名分页
            resultList = contestRankManager.getContestACMRankPage(isOpenSealRank,
                    removeStar,
                    userRolesVo.getUid(),
                    concernedList,
                    contestRankDTO.getExternalCidList(),
                    contest,currentPage,
                    limit,
                    contestRankDTO.getKeyword());
        } else {
            // TODO  // OI比赛

        }
        return resultList;
    }

    public IPage<AnnouncementVO> getContestAnnouncement(Long cid, Integer limit, Integer currentPage) throws StatusForbiddenException, StatusFailException {

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 获取本场比赛的状态
        Contest contest = contestEntityService.getById(cid);

        // 超级管理员或者该比赛的创建者，则为比赛管理者
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        // 需要对该比赛做判断，是否处于开始或结束状态才可以获取题目，同时若是私有赛需要判断是否已注册（比赛管理员包括超级管理员可以直接获取）
        contestValidator.validateContestAuth(contest, userRolesVo, isRoot);
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return announcementEntityService.getContestAnnouncement(cid, true, limit, currentPage);
    }

    public List<ProblemFullScreenListVO> getContestFullScreenProblemList(Long cid) throws StatusForbiddenException, StatusFailException {
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 获取本场比赛的状态
        Contest contest = contestEntityService.getById(cid);

        // 超级管理员或者该比赛的创建者，则为比赛管理者
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        // 需要对该比赛做判断，是否处于开始或结束状态才可以获取题目列表，同时若是私有赛需要判断是否已注册（比赛管理员包括超级管理员可以直接获取）
        contestValidator.validateContestAuth(contest,userRolesVo,isRoot);

        List<ProblemFullScreenListVO> problemList = contestProblemEntityService.getContestFullScreenProblemList(cid);
        List<Long> pidList = problemList.stream().map(ProblemFullScreenListVO::getPid).collect(Collectors.toList());

        QueryWrapper<Judge> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("distinct pid, status, score, submit_time")
                .in("pid", pidList)
                .eq("uid", userRolesVo.getUid())
                .orderByDesc("submit_time");

        queryWrapper.eq("cid", cid);

        boolean isACMContest = contest.getType().intValue() == Constants.Contest.TYPE_ACM.getCode();

        List<Judge> judges = judgeEntityService.list(queryWrapper);

        boolean isSealRank = false;
        if(!isACMContest && CollectionUtil.isNotEmpty(judges)) {
            isSealRank = contestValidator.isSealRank(userRolesVo.getUid(), contest, false, isRoot);
        }
        HashMap<Long, Pair_<Integer,Integer>> pidMap = new HashMap<>();
        for(Judge judge: judges) {
            if (Objects.equals(judge.getStatus(), Constants.Judge.STATUS_PENDING.getStatus())
                    || Objects.equals(judge.getStatus(), Constants.Judge.STATUS_COMPILING.getStatus())
                    || Objects.equals(judge.getStatus(), Constants.Judge.STATUS_JUDGING.getStatus())) {
                continue;
            }
            if(!isACMContest) {
                if(!pidMap.containsKey(judge.getPid())) {
                    // IO比赛的，如果还未写入，则使用最新一次提交的结果
                    // 判断该提交是否为封榜之后的提交,OI赛制封榜后的提交看不到提交结果，
                    // 只有比赛结束可以看到,比赛管理员与超级管理员的提交除外
                    if(isSealRank) {
                        pidMap.put(judge.getPid(), new Pair_<>(Constants.Judge.STATUS_SUBMITTED_UNKNOWN_RESULT.getStatus(),null));
                    } else {
                        pidMap.put(judge.getPid(), new Pair_<>(judge.getStatus(), judge.getScore()));
                    }
                }
            } else {
                if(judge.getStatus().intValue() == Constants.Judge.STATUS_ACCEPTED.getStatus()) {
                    // 如果该题目已通过，且同时是为不封榜前提交的，则强制写为通过（0）
                    pidMap.put(judge.getPid(), new Pair_<>(judge.getStatus(), judge.getScore()));
                } else if(!pidMap.containsKey(judge.getPid())) {
                    // 还未写入，则使用最新一次提交的结果
                    pidMap.put(judge.getPid(), new Pair_<>(judge.getStatus(), judge.getScore()));
                }
            }
        }
        for(ProblemFullScreenListVO problemVo: problemList) {
            Pair_<Integer,Integer> pair_ = pidMap.get(problemVo.getPid());
            if(pair_ != null) {
                problemVo.setStatus(pair_.getKey());
                problemVo.setScore(pair_.getValue());
            }
        }
        return problemList;
    }

    public AccessVO getContestAccess(Long cid) throws StatusFailException {
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        QueryWrapper<ContestRegister> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("cid", cid).eq("uid", userRolesVo.getUid());
        ContestRegister contestRegister = contestRegisterEntityService.getOne(queryWrapper, false);

        boolean access = false;
        if(contestRegister != null) {
            access = true;
            Contest contest = contestEntityService.getById(cid);
            if(contest == null || !contest.getVisible()) {
                throw new StatusFailException("对不起，该比赛不存在!");
            }
            if(contest.getOpenAccountLimit()
                    && !contestValidator.validateAccountRule(contest.getAccountLimitRule(), userRolesVo.getUsername())) {
                access = false;
                contestRegisterEntityService.removeById(contestRegister.getId());
            }
        }
        AccessVO accessVO = new AccessVO();
        accessVO.setAccess(access);
        return accessVO;
    }
}
