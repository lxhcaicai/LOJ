package com.github.loj.service.oj.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.oj.ContestAdminManager;
import com.github.loj.pojo.dto.CheckACDTO;
import com.github.loj.pojo.entity.contest.ContestPrint;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.service.oj.ContestAdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class ContestAdminServiceImpl implements ContestAdminService {

    @Resource
    private ContestAdminManager contestAdminManager;

    @Override
    public CommonResult<IPage<ContestRecord>> getContestACInfo(Long cid, Integer currentPage, Integer limit) {
        try {
            return CommonResult.successResponse(contestAdminManager.getContestACInfo(cid, currentPage, limit));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        }
    }

    @Override
    public CommonResult<IPage<ContestPrint>> getContestPrint(Long cid, Integer currentPage, Integer limit) {
        try {
            return CommonResult.successResponse(contestAdminManager.getContestPrint(cid, currentPage, limit));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        }
    }

    @Override
    public CommonResult<Void> checkContestACInfo(CheckACDTO checkACDTO) {
        try {
            contestAdminManager.checkContestACInfo(checkACDTO);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
