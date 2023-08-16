package com.github.loj.service.group.training;

import com.github.loj.common.result.CommonResult;

import java.util.HashMap;

public interface GroupTrainingProblemService {
    public CommonResult<HashMap<String, Object>> getTrainingProblemList(Integer limit, Integer currentPage, String keyword, Boolean queryExisted, Long tid);
}
