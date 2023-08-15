package com.github.loj.manager.group.problem;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.dao.group.GroupProblemEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

@Component
@RefreshScope
public class GroupProblemManager {

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private GroupProblemEntityService groupProblemEntityService;

    public IPage<ProblemVO> getProblemList(Integer limit, Integer currentPage, Long gid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);

        if (group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取题目列表失败，该团队不存在或已被封禁！");
        }

        if (!groupValidator.isGroupMember(userRolesVo.getUid(), gid) && !isRoot) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return groupProblemEntityService.getProblemList(limit, currentPage, gid);
    }

    public IPage<Problem> getAdminProblemList(Integer limit, Integer currentPage, Long gid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);

        if (group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取题目列表失败，该团队不存在或已被封禁！");
        }

        if (!groupValidator.isGroupMember(userRolesVo.getUid(), gid) && !isRoot) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return groupProblemEntityService.getAdminProblemList(limit, currentPage, gid);
    }

    public Problem getProblem(Long pid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Problem problem = problemEntityService.getById(pid);

        if(problem == null) {
            throw new StatusNotFoundException("该题目不存在！");
        }

        Long gid = problem.getGid();

        if(gid == null) {
            throw new StatusForbiddenException("获取失败，不可访问非团队内的题目！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取失败，该团队不存在或已被封禁！");
        }

        if(!groupValidator.isGroupRoot(userRolesVo.getUid(), gid) && !userRolesVo.getUsername().equals(problem.getAuthor()) && !isRoot) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        return problem;
    }
}
