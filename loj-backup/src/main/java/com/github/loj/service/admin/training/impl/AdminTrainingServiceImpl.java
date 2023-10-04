package com.github.loj.service.admin.training.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.admin.training.AdminTrainingManager;
import com.github.loj.pojo.dto.TrainingDTO;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.service.admin.training.AdminTrainingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminTrainingServiceImpl implements AdminTrainingService {

    @Autowired
    private AdminTrainingManager adminTrainingManager;

    @Override
    public CommonResult<IPage<Training>> getTrainingList(Integer limit, Integer currentPage, String keyword) {
        return CommonResult.successResponse(adminTrainingManager.getTrainingList(limit, currentPage, keyword));
    }

    @Override
    public CommonResult<TrainingDTO> getTraining(Long tid) {
        try {
            TrainingDTO training = adminTrainingManager.getTraining(tid);
            return CommonResult.successResponse(training);
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> deleteTraining(Long tid) {
        try {
            adminTrainingManager.deleteTraining(tid);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> addTraining(TrainingDTO trainingDTO) {
        try {
            adminTrainingManager.addTraining(trainingDTO);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> updateTraining(TrainingDTO trainingDTO) {
        try {
            adminTrainingManager.updateTraining(trainingDTO);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> changeTrainingStatus(Long tid, String author, Boolean status) {
        try {
            adminTrainingManager.changeTrainingStatus(tid, author, status);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
