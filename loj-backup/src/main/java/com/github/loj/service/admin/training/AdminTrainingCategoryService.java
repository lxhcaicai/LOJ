package com.github.loj.service.admin.training;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.training.TrainingCategory;

public interface AdminTrainingCategoryService {
    public CommonResult<TrainingCategory> addTrainingCategory(TrainingCategory trainingCategory);

    public CommonResult<Void> updateTrainingCategory(TrainingCategory trainingCategory);

    public CommonResult<Void> deleteTrainingCategory(Long cid);
}
