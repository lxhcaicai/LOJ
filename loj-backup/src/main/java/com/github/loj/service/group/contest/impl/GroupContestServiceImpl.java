package com.github.loj.service.group.contest.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.group.contest.GroupContestManager;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.AdminContestVO;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.service.group.contest.GroupContestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GroupContestServiceImpl implements GroupContestService {

    @Autowired
    private GroupContestManager groupContestManager;

    @Override
    public CommonResult<IPage<ContestVO>> getContestList(Integer limit, Integer currentPage, Long gid) {
        try {
            return CommonResult.successResponse(groupContestManager.getContestList(limit,currentPage,gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<IPage<Contest>> getAdminContestList(Integer limit, Integer currentPage, Long gid) {
        try {
            return CommonResult.successResponse(groupContestManager.getAdminContestList(limit,currentPage,gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<AdminContestVO> getContest(Long cid) {
        try {
            return CommonResult.successResponse(groupContestManager.getContest(cid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<Void> addContest(AdminContestVO adminContestVO) {
        try {
            groupContestManager.addContest(adminContestVO);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FAIL);
        }
    }

    @Override
    public CommonResult<Void> updateContest(AdminContestVO adminContestVO) {
        try {
            groupContestManager.updateContest(adminContestVO);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FAIL);
        }
    }
}
