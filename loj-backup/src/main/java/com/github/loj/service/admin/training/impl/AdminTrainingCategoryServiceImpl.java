package com.github.loj.service.admin.training.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.training.AdminTrainingCategoryManager;
import com.github.loj.pojo.entity.training.TrainingCategory;
import com.github.loj.service.admin.training.AdminTrainingCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminTrainingCategoryServiceImpl implements AdminTrainingCategoryService {

    @Autowired
    private AdminTrainingCategoryManager adminTrainingCategoryManager;

    @Override
    public CommonResult<TrainingCategory> addTrainingCategory(TrainingCategory trainingCategory) {
        try {
            return CommonResult.successResponse(adminTrainingCategoryManager.addTrainingCategory(trainingCategory));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> updateTrainingCategory(TrainingCategory trainingCategory) {
        try {
            adminTrainingCategoryManager.updateTrainingCategory(trainingCategory);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
