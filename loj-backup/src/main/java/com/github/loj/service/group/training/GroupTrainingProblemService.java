package com.github.loj.service.group.training;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.TrainingProblemDTO;
import com.github.loj.pojo.entity.training.TrainingProblem;

import java.util.HashMap;

public interface GroupTrainingProblemService {
    public CommonResult<HashMap<String, Object>> getTrainingProblemList(Integer limit, Integer currentPage, String keyword, Boolean queryExisted, Long tid);

    public CommonResult<Void> updateTrainingProblem(TrainingProblem trainingProblem);

    public CommonResult<Void> deleteTrainingProblem(Long pid, Long tid);

    public CommonResult<Void> addProblemFromPublic(TrainingProblemDTO trainingProblemDTO);
}
