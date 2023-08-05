package com.github.loj.service.admin.contest.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.admin.contest.AdminContestManager;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.AdminContestVO;
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

    @Override
    public CommonResult<AdminContestVO> getContest(Long cid) {
        try {
            AdminContestVO adminContestVO = adminContestManager.getContest(cid);
            return CommonResult.successResponse(adminContestVO);
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> deleteContest(Long cid) {
        try {
            adminContestManager.deleteContest(cid);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> addContest(AdminContestVO adminContestVO) {
        try {
            adminContestManager.addContest(adminContestVO);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> updateContest(AdminContestVO adminContestVO) {
        try {
            adminContestManager.updateContest(adminContestVO);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
