package com.github.loj.manager.admin.problem;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.utils.Constants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@Component
@RefreshScope
@Slf4j(topic = "loj")
public class AdminProblemManager {

    @Autowired
    private ProblemEntityService problemEntityService;

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
}
