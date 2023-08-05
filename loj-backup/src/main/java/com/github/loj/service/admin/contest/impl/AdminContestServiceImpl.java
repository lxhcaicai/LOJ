package com.github.loj.service.admin.contest.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.contest.AdminContestManager;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.service.admin.contest.AdminContestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminContestServiceImpl implements AdminContestService {

    @Autowired
    private AdminContestManager adminContestManager;

    @Override
    public CommonResult<IPage<Contest>> getContestList(Integer limit, Integer currentPage, String keyword) {
        IPage<Contest> contestList = adminContestManager.getContestList(limit, currentPage, keyword);
        return CommonResult.successResponse(contestList);
    }
}
