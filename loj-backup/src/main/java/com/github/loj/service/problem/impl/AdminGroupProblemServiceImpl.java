package com.github.loj.service.problem.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.problem.AdminGroupProblemManager;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.service.problem.AdminGroupProblemService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AdminGroupProblemServiceImpl implements AdminGroupProblemService {

    @Resource
    private AdminGroupProblemManager adminGroupProblemManager;

    @Override
    public CommonResult<IPage<Problem>> getProblemList(Integer currentPage, Integer limit, String keyword, Long gid) {
        return CommonResult.successResponse(adminGroupProblemManager.list(currentPage, limit, keyword, gid));
    }
}
