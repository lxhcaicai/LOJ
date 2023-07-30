package com.github.loj.manager.oj;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestPrintEntityService;
import com.github.loj.dao.contest.ContestRecordEntityService;
import com.github.loj.pojo.dto.CheckACDTO;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestPrint;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ContestAdminManager {

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private ContestRecordEntityService contestRecordEntityService;

    @Autowired
    private ContestPrintEntityService contestPrintEntityService;

    public IPage<ContestRecord> getContestACInfo(Long cid, Integer currentPage, Integer limit) throws StatusForbiddenException {

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 获取本场比赛的状态
        Contest contest = contestEntityService.getById(cid);

        // 超级管理员或者该比赛的创建者，则为比赛管理者
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        if(!isRoot
                && !contest.getUid().equals(userRolesVo.getUid())
                && !(contest.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), contest.getGid()))) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 30;
        }

        // 获取当前比赛的，状态为ac，未被校验的排在前面
        return contestRecordEntityService.getACInfo(currentPage,
                limit,
                Constants.Contest.RECORD_AC.getCode(),
                cid,
                contest.getUid());
    }

    public IPage<ContestPrint> getContestPrint(Long cid, Integer currentPage, Integer limit) throws StatusForbiddenException {

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 获取本场比赛的状态
        Contest contest = contestEntityService.getById(cid);

        // 超级管理员或者该比赛的创建者，则为比赛管理者
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        if(!isRoot
                && !contest.getUid().equals(userRolesVo.getUid())
                && !(contest.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), contest.getGid()))) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 30;
        }

        // 获取当前比赛的，未被确定的排在签名
        IPage<ContestPrint>  contestPrintIPage = new Page<>(currentPage, limit);

        QueryWrapper<ContestPrint> contestPrintQueryWrapper = new QueryWrapper<>();
        contestPrintQueryWrapper.select("id","cid","username","realname","status","gmt_create")
                .eq("cid", cid)
                .orderByAsc("status")
                .orderByDesc("gmt_create");

        return contestPrintEntityService.page(contestPrintIPage, contestPrintQueryWrapper);
    }

    public void checkContestACInfo(CheckACDTO checkACDTO) throws StatusForbiddenException, StatusFailException {

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 获取本场比赛的状态
        Contest contest = contestEntityService.getById(checkACDTO.getCid());

        // 超级管理员或者该比赛的创建者，则为比赛管理者
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        if(!isRoot
                && !contest.getUid().equals(userRolesVo.getUid())
                && !(contest.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), contest.getGid()))) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        boolean isOk = contestRecordEntityService.updateById(
                new ContestRecord().setChecked(checkACDTO.getChecked()).setId(checkACDTO.getId()));

        if(!isOk) {
            throw new StatusFailException("修改失败");
        }
    }

    public void checkContestPrintStatus(Long id, Long cid) throws StatusForbiddenException, StatusFailException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 获取本场比赛的状态
        Contest contest = contestEntityService.getById(cid);

        // 超级管理员或者该比赛的创建者，则为比赛管理者
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        if(!isRoot
                && !contest.getUid().equals(userRolesVo.getUid())
                && !(contest.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), contest.getGid()))) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        boolean isOk = contestPrintEntityService.updateById(new ContestPrint().setId(id).setStatus(1));

        if(!isOk) {
            throw new StatusFailException("修改失败！");
        }
    }
}
