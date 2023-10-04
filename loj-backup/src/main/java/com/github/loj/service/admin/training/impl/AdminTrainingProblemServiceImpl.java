package com.github.loj.service.admin.training.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.training.AdminTrainingProblemManager;
import com.github.loj.pojo.entity.training.TrainingProblem;
import com.github.loj.service.admin.training.AdminTrainingProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class AdminTrainingProblemServiceImpl implements AdminTrainingProblemService {

    @Autowired
    private AdminTrainingProblemManager adminTrainingProblemManager;

    @Override
    public CommonResult<HashMap<String, Object>> getProblemList(Integer limit, Integer currentPage, String keyword, Boolean queryExisted, Long tid) {
        HashMap<String, Object> problemMap = adminTrainingProblemManager.getProblemList(limit, currentPage, keyword, queryExisted, tid);
        return CommonResult.successResponse(problemMap);
    }

    @Override
    public CommonResult<Void> updateProblem(TrainingProblem trainingProblem) {
        try {
            adminTrainingProblemManager.updateProblem(trainingProblem);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> deleteProblem(Long pid, Long tid) {
        try {
            adminTrainingProblemManager.deleteProblem(pid, tid);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
