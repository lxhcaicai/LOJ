package com.github.loj.manager.admin.problem;

import cn.hutool.core.io.FileUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.ProblemValidator;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.io.File;

@Component
@RefreshScope
@Slf4j(topic = "loj")
public class AdminProblemManager {

    @Autowired
    private ProblemEntityService problemEntityService;

    @Resource
    private ProblemValidator problemValidator;

    public IPage<Problem> getProblemList(Integer limit, Integer currentPage, String keyword, Integer auth, String oj) {

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        IPage<Problem> iPage = new Page<>(currentPage, limit);
        IPage<Problem> problemList;

        QueryWrapper<Problem> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("is_group",false)
                .orderByDesc("id");

        // 根据oj筛选过滤
        if(oj != null && !"All".equals(oj)) {
            if(!Constants.RemoteOJ.isRemoteOJ(oj)) {
                queryWrapper.eq("is_remote",false);
            } else {
                queryWrapper.eq("is_remote",true).likeRight("problem_id",oj);
            }
        }

        if(auth != null && auth != 0) {
            queryWrapper.eq("auth",auth);
        }

        if(!StringUtils.isEmpty(keyword)) {
            final String key = keyword.trim();
            queryWrapper.and(wrapper -> wrapper.like("title", key).or()
                    .like("author", key).or()
                    .like("problem_id",key));
            problemList = problemEntityService.page(iPage,queryWrapper);
        } else {
            problemList = problemEntityService.page(iPage, queryWrapper);
        }
        return problemList;
    }

    public Problem getProblem(Long pid) throws StatusFailException, StatusForbiddenException {

        Problem problem = problemEntityService.getById(pid);
        if(problem != null) {
            // 获取当前登录的用户
            AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

            boolean isRoot = SecurityUtils.getSubject().hasRole("root");
            boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
            // 只有超级管理员和题目管理员、题目创建者才能操作
            if(!isRoot && !isProblemAdmin && !userRolesVo.getUsername().equals(problem.getAuthor())) {
                throw new StatusForbiddenException("对不起，你无权限查看题目！");
            }
            return problem;
        } else {
            throw new StatusFailException("查询失败！");
        }
    }

    public void deleteProblem(Long pid) throws StatusFailException {
        boolean isOk = problemEntityService.removeById(pid);
        // problem的id为其他表的外键的表中的对应数据都会被一起删除！
        if(isOk) {
            FileUtil.del(Constants.File.TESTCASE_BASE_FOLDER.getPath() + File.separator + "problem_" + pid);
            AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
            log.info("[{}],[{}],pid:[{}],operatorUid:[{}],operatorUsername:[{}]",
                    "Admin_Problem", "Delete", pid, userRolesVo.getUid(), userRolesVo.getUsername());
        } else {
            throw new StatusFailException("删除失败！");
        }
    }

    public void addProblem(ProblemDTO problemDTO) throws StatusFailException {
        problemValidator.validateeProblem(problemDTO.getProblem());
        QueryWrapper<Problem> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("problem_id", problemDTO.getProblem().getProblemId().toUpperCase());
        Problem problem = problemEntityService.getOne(queryWrapper);
        if(problem != null) {
            throw new StatusFailException("该题目的Problem ID已存在，请更换！");
        }

        boolean isOk = problemEntityService.adminAddProblem(problemDTO);
        if(isOk) {
            throw new StatusFailException("添加失败");
        }
    }
}
