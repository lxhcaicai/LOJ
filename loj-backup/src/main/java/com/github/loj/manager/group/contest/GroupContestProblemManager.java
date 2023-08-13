package com.github.loj.manager.group.contest;

import cn.hutool.core.map.MapUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.manager.admin.contest.AdminContestProblemManager;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.GroupValidator;
import com.github.loj.validator.ProblemValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Component
public class GroupContestProblemManager {

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private ProblemValidator problemValidator;

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

    public Map<Object, Object> addProblem(ProblemDTO problemDTO) throws StatusFailException, StatusNotFoundException, StatusForbiddenException {

        problemValidator.validateeProblem(problemDTO.getProblem());

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long gid = problemDTO.getProblem().getGid();

        if(gid == null) {
            throw new StatusNotFoundException("添加失败，题目所属的团队ID不可为空！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("添加失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupAdmin(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        problemDTO.getProblem().setProblemId(group.getShortName() + problemDTO.getProblem().getProblemId());

        QueryWrapper<Problem> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("problem_id", problemDTO.getProblem().getProblemId().toUpperCase());

        Problem problem = problemEntityService.getOne(queryWrapper);
        if(problem != null) {
            throw new StatusFailException("该题目的Problem ID已存在，请更换！");
        }

        problemDTO.getProblem().setAuth(3);
        problemDTO.getProblem().setIsGroup(true);

        List<Tag> tagList = new LinkedList<>();
        for(Tag tag: problemDTO.getTags()) {
            if(tag.getGid() != null && !tag.getGid().equals(gid)) {
                throw new StatusForbiddenException("对不起，您无权限操作！");
            }

            if(tag.getId() == null) {
                tag.setGid(gid);
            }

            tagList.add(tag);
        }

        problemDTO.setTags(tagList);

        boolean isOk = problemEntityService.adminAddProblem(problemDTO);
        if(isOk) {
            return MapUtil.builder().put("pid", problemDTO.getProblem().getId()).map();
        } else {
            throw new StatusFailException("添加失败");
        }
    }
}