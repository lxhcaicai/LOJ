package com.github.loj.service.group.contest.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.group.contest.GroupContestProblemManager;
import com.github.loj.pojo.dto.ContestProblemDTO;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.service.group.contest.GroupContestProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class GroupContestProblemServiceImpl implements GroupContestProblemService {

    @Autowired
    private GroupContestProblemManager groupContestProblemManager;

    @Override
    public CommonResult<HashMap<String, Object>> getContestProblemList(Integer limit, Integer currentPage, String keyword, Long cid, Integer problemType, String oj) {
        try {
            return CommonResult.successResponse(groupContestProblemManager.getContestProblemList(limit,currentPage,keyword,cid,problemType,oj));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<Map<Object, Object>> addProblem(ProblemDTO problemDTO) {
        try {
            return CommonResult.successResponse(groupContestProblemManager.addProblem(problemDTO));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FAIL);
        }
    }

    @Override
    public CommonResult<Void> updateContestProblem(ContestProblem contestProblem) {
        try {
            groupContestProblemManager.updateContestProblem(contestProblem);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FAIL);
        }
    }

    @Override
    public CommonResult<ContestProblem> getContestProblem(Long pid, Long cid) {
        try {
            return CommonResult.successResponse(groupContestProblemManager.getContestProblem(pid,cid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FAIL);
        }
    }

    @Override
    public CommonResult<Void> deleteContestProblem(Long pid, Long cid) {
        try {
            groupContestProblemManager.deleteContestProblem(pid,cid);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FAIL);
        }
    }

    @Override
    public CommonResult<Void> addProblemFromPublic(ContestProblemDTO contestProblemDTO) {
        try {
            groupContestProblemManager.addProblemFromPublic(contestProblemDTO);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FAIL);
        }
    }

}
