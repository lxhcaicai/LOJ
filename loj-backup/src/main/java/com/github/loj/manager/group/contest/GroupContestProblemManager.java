package com.github.loj.manager.group.contest;

import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.manager.admin.contest.AdminContestProblemManager;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;

@Component
public class GroupContestProblemManager {

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private AdminContestProblemManager adminContestProblemManager;



    public HashMap<String,Object> getContestProblemList(Integer limit, Integer currentPage, String keyword, Long cid, Integer problemType, String oj) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Contest contest = contestEntityService.getById(cid);

        if(contest == null) {
            throw new StatusNotFoundException("获取失败，该比赛不存在！");
        }

        Long gid = contest.getGid();
        if(gid == null) {
            throw new StatusForbiddenException("获取失败，不可获取非团队内的比赛题目列表！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取比赛题目列表失败，该团队不存在或已被封禁！");
        }

        if(!groupValidator.isGroupRoot(userRolesVo.getUid(),gid) && !userRolesVo.getUid().equals(contest.getUid()) && !isRoot) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        return adminContestProblemManager.getProblemList(limit,currentPage,keyword,cid,problemType,oj);
    }
}
