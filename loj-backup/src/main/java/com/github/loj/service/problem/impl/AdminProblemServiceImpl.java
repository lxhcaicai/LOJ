package com.github.loj.service.problem.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.problem.AdminProblemManager;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.service.problem.AdminProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminProblemServiceImpl implements AdminProblemService {

    @Autowired
    private AdminProblemManager adminProblemManager;

    @Override
    public CommonResult<IPage<Problem>> getProblemList(Integer limit, Integer currentPage, String keyword, Integer auth, String oj) {
        IPage<Problem> problemList = adminProblemManager.getProblemList(limit,currentPage,keyword,auth,oj);
        return CommonResult.successResponse(problemList);
    }
}
