package com.github.loj.service.admin.training;

import com.github.loj.common.result.CommonResult;

import java.util.HashMap;

public interface AdminTrainingProblemService {
    public CommonResult<HashMap<String, Object>> getProblemList(Integer limit, Integer currentPage, String keyword, Boolean queryExisted, Long tid);
}
