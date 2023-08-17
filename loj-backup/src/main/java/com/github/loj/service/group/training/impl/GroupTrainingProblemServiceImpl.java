package com.github.loj.service.group.training.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.group.training.GroupTrainingProblemManager;
import com.github.loj.pojo.entity.training.TrainingProblem;
import com.github.loj.service.group.training.GroupTrainingProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class GroupTrainingProblemServiceImpl implements GroupTrainingProblemService {

    @Autowired
    private GroupTrainingProblemManager groupTrainingProblemManager;

    @Override
    public CommonResult<HashMap<String, Object>> getTrainingProblemList(Integer limit, Integer currentPage, String keyword, Boolean queryExisted, Long tid) {
        try {
            return CommonResult.successResponse(groupTrainingProblemManager.getTrainingProblemList(limit,currentPage,keyword,queryExisted,tid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<Void> updateTrainingProblem(TrainingProblem trainingProblem) {
        try {
            groupTrainingProblemManager.updateTrainingProblem(trainingProblem);
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
