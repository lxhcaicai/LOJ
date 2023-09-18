package com.github.loj.service.admin.contest.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.admin.contest.AdminContestProblemManager;
import com.github.loj.pojo.dto.ContestProblemDTO;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.service.admin.contest.AdminContestProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class AdminContestProblemServiceImpl implements AdminContestProblemService {

    @Autowired
    private AdminContestProblemManager adminContestProblemManager;

    @Override
    public CommonResult<HashMap<String, Object>> getProblemList(Integer limit, Integer currentPage, String keyword, Long cid, Integer problemType, String oj) {

        HashMap<String,Object> problemList = adminContestProblemManager.getProblemList(limit,currentPage,keyword, cid,problemType, oj);
        return CommonResult.successResponse(problemList);
    }

    @Override
    public CommonResult<Problem> getProblem(Long pid) {
        try {
            Problem problem = adminContestProblemManager.getProblem(pid);
            return CommonResult.successResponse(problem);
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> deleteProblem(Long pid, Long cid) {
        adminContestProblemManager.deleteProblem(pid, cid);
        return CommonResult.successResponse();
    }

    @Override
    public CommonResult<Map<Object, Object>> addProblem(ProblemDTO problemDTO) {
        try {
            Map<Object,Object> problemMap = adminContestProblemManager.addProblem(problemDTO);
            return CommonResult.successResponse(problemMap);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> updateProblem(ProblemDTO problemDTO) {
        try {
            adminContestProblemManager.updateProblem(problemDTO);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<ContestProblem> getContestProblem(Long cid, Long pid) {
        try {
            ContestProblem contestProblem = adminContestProblemManager.getContestProblem(cid, pid);
            return CommonResult.successResponse(contestProblem);
        } catch (StatusFailException e) {
            return CommonResult.successResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<ContestProblem> setContestProblem(ContestProblem contestProblem) {
        try {
            return CommonResult.successResponse(adminContestProblemManager.setContestProblem(contestProblem));
        } catch (StatusFailException e) {
            return CommonResult.successResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> addProblemFromPublic(ContestProblemDTO contestProblemDTO) {
        try {
            adminContestProblemManager.addProblemFromPublic(contestProblemDTO);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.successResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> importContestRemoteOJProblem(String name, String problemId, Long cid, String displayId) {
        try {
            adminContestProblemManager.importContestRemoteOJProblem(name, problemId, cid, displayId);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
