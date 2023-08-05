package com.github.loj.service.admin.contest;

import com.github.loj.common.result.CommonResult;

import java.util.HashMap;

public interface AdminContestProblemService {

    public CommonResult<HashMap<String,Object>> getProblemList(Integer limit, Integer currentPage, String keyword,
                                                               Long cid, Integer problemType, String oj);
}
