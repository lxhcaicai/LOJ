package com.github.loj.service.admin.training;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.TrainingDTO;
import com.github.loj.pojo.entity.training.Training;

public interface AdminTrainingService {
    public CommonResult<IPage<Training>> getTrainingList(Integer limit, Integer currentPage, String keyword);

    public CommonResult<TrainingDTO> getTraining(Long tid);

    public CommonResult<Void> deleteTraining(Long tid);

    public CommonResult<Void> addTraining(TrainingDTO trainingDTO);

    public CommonResult<Void> updateTraining(TrainingDTO trainingDTO);

    public CommonResult<Void> changeTrainingStatus(Long tid, String author, Boolean status);
}
