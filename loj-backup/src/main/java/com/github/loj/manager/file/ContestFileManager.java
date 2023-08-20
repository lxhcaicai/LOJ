package com.github.loj.manager.file;

import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestProblemEntityService;
import com.github.loj.manager.oj.ContestCalculateRankManager;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.pojo.vo.ACMContestRankVO;
import com.github.loj.pojo.vo.OIContestRankVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.ContestValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.stream.Collectors;

@Component
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
    private ContestCalculateRankManager contestCalculateRankManager;

    @Autowired
    private FileEntityService fileEntityService;

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
}
