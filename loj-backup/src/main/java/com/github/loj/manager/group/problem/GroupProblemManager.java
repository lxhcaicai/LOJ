package com.github.loj.manager.group.problem;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.dao.group.GroupProblemEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.GroupValidator;
import com.github.loj.validator.ProblemValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.List;

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
    private ProblemValidator problemValidator;

    @Autowired
    private JudgeEntityService judgeEntityService;

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

    public void addProblem(ProblemDTO problemDTO) throws StatusFailException, StatusForbiddenException, StatusNotFoundException {
        problemValidator.validateGroupProblem(problemDTO.getProblem());

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long gid = problemDTO.getProblem().getGid();

        if(gid == null) {
            throw new StatusForbiddenException("添加失败，题目所属团队ID不可为空！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("添加失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupAdmin(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        problemDTO.getProblem().setProblemId(group.getShortName() + problemDTO.getProblem().getProblemId());

        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
        problemQueryWrapper.eq("problem_id", problemDTO.getProblem().getProblemId().toUpperCase());
        int sameProblemIDCount = problemEntityService.count(problemQueryWrapper);
        if(sameProblemIDCount > 0) {
            throw new StatusFailException("该题目的Problem ID已存在，请更换！");
        }

        problemDTO.getProblem().setIsGroup(true);

        problemDTO.getProblem().setApplyPublicProgress(null);

        List<Tag> tagList = new LinkedList<>();
        for(Tag tag: problemDTO.getTags()) {
            if(tag.getGid() != null && tag.getGid().longValue() != gid) {
                throw new StatusForbiddenException("对不起，您无权限操作！");
            }
            if(tag.getId() == null) {
                tag.setGid(gid);
            }
            tagList.add(tag);
        }
        problemDTO.setTags(tagList);

        boolean isOk = problemEntityService.adminAddProblem(problemDTO);
        if(!isOk) {
            throw new StatusFailException("添加失败");
        }
    }

    public void updateProblem(ProblemDTO problemDTO) throws StatusFailException, StatusNotFoundException, StatusForbiddenException {
        problemValidator.validateGroupProblem(problemDTO.getProblem());

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long pid = problemDTO.getProblem().getId();

        Problem problem = problemEntityService.getById(pid);

        if (problem == null) {
            throw new StatusNotFoundException("该题目不存在！");
        }

        Long gid = problem.getGid();

        if(gid == null) {
            throw new StatusForbiddenException("更新失败，不可操作非团队内的题目！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("更新失败，该团队不存在或已被封禁！");
        }

        if(!userRolesVo.getUsername().equals(problem.getAuthor())
                && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        problemDTO.getProblem().setProblemId(group.getShortName() + problemDTO.getProblem().getProblemId());
        String problemId = problemDTO.getProblem().getProblemId().toUpperCase();

        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
        problemQueryWrapper.eq("problem_id", problemId);

        Problem existedProblem = problemEntityService.getOne(problemQueryWrapper);

        problemDTO.getProblem().setModifiedUser(userRolesVo.getUsername());

        if(existedProblem != null && existedProblem.getId().longValue() != pid) {
            throw new StatusFailException("当前的Problem ID 已被使用，请重新更换新的！");
        }

        problemDTO.getProblem().setIsGroup(problem.getIsGroup());

        List<Tag> tagList = new LinkedList<>();
        for(Tag tag: problemDTO.getTags()) {
            if(tag.getGid() != null && tag.getGid().longValue() != gid) {
                throw new StatusForbiddenException("对不起，您无权限操作！");
            }
            if(tag.getId() == null) {
                tag.setGid(gid);
            }
            tagList.add(tag);
        }
        problemDTO.setTags(tagList);
        problemDTO.getProblem().setApplyPublicProgress(null);

        boolean isOk = problemEntityService.adminUpdateProblem(problemDTO);
        if(isOk) {
            if(existedProblem == null) {
                UpdateWrapper<Judge> judgeUpdateWrapper = new UpdateWrapper<>();
                judgeUpdateWrapper.eq("pid", problemDTO.getProblem().getId())
                        .set("display_pid", problemId);
                judgeEntityService.update(judgeUpdateWrapper);
            }
        } else {
            throw new StatusFailException("修改失败");
        }

    }
}
