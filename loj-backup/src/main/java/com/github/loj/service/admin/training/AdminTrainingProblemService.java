package com.github.loj.service.admin.training;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.TrainingProblemDTO;
import com.github.loj.pojo.entity.training.TrainingProblem;

import java.util.HashMap;

public interface AdminTrainingProblemService {
    public CommonResult<HashMap<String, Object>> getProblemList(Integer limit, Integer currentPage, String keyword, Boolean queryExisted, Long tid);

    public CommonResult<Void> updateProblem(TrainingProblem trainingProblem);

    public CommonResult<Void> deleteProblem(Long pid, Long tid);

    public CommonResult<Void> addProblemFromPublic(TrainingProblemDTO trainingProblemDTO);
}
