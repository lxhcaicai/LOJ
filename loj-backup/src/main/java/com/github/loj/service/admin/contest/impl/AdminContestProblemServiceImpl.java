package com.github.loj.service.admin.contest.impl;

import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.contest.AdminContestProblemManager;
import com.github.loj.service.admin.contest.AdminContestProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class AdminContestProblemServiceImpl implements AdminContestProblemService {

    @Autowired
    private AdminContestProblemManager adminContestProblemManager;

    @Override
    public CommonResult<HashMap<String, Object>> getProblemList(Integer limit, Integer currentPage, String keyword, Long cid, Integer problemType, String oj) {

        HashMap<String,Object> problemList = adminContestProblemManager.getProblemList(limit,currentPage,keyword, cid,problemType, oj);
        return CommonResult.successResponse(problemList);
    }
}
