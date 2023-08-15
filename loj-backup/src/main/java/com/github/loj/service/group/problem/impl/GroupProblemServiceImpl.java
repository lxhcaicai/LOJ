package com.github.loj.service.group.problem.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.group.problem.GroupProblemManager;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.service.group.problem.GroupProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GroupProblemServiceImpl implements GroupProblemService {

    @Autowired
    private GroupProblemManager groupProblemManager;

    @Override
    public CommonResult<IPage<ProblemVO>> getProblemList(Integer limit, Integer currentPage, Long gid) {
        try {
            return CommonResult.successResponse(groupProblemManager.getProblemList(limit, currentPage, gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<IPage<Problem>> getAdminProblemList(Integer limit, Integer currentPage, Long gid) {
        try {
            return CommonResult.successResponse(groupProblemManager.getAdminProblemList(limit, currentPage, gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<Problem> getProblem(Long pid) {
        try {
            return CommonResult.successResponse(groupProblemManager.getProblem(pid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<Problem> addProblem(ProblemDTO problemDTO) {
        try {
            groupProblemManager.addProblem(problemDTO);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
