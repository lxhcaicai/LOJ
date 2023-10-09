package com.github.loj.manager.admin.problem;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.pojo.entity.problem.Problem;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;

@Component
public class AdminGroupProblemManager {

    @Resource
    private ProblemEntityService problemEntityService;

    public IPage<Problem> list(Integer currentPage, Integer limit, String keyword, Long gid) {
        if (currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if (limit == null || limit < 1) {
            limit = 10;
        }
        IPage<Problem> iPage = new Page<>(currentPage, limit);
        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
        problemQueryWrapper.select("id", "gid", "apply_public_progress", "problem_id", "title", "author", "type", "judge_mode")
                .eq(gid != null, "gid", gid)
                .isNotNull("gid")
                .isNotNull("apply_public_progress")
                .orderByAsc("apply_public_progress", "gid");

        if (!StringUtils.isEmpty(keyword)) {
            problemQueryWrapper.and(wrapper -> wrapper.like("title", keyword).or()
                    .like("author", keyword).or()
                    .like("problem_id", keyword));
        }

        return problemEntityService.page(iPage,problemQueryWrapper);
    }
}
