package com.github.loj.service.group.contest;

import com.github.loj.common.result.CommonResult;

import java.util.HashMap;

public interface GroupContestProblemService {
    public CommonResult<HashMap<String, Object>> getContestProblemList(Integer limit, Integer currentPage, String keyword, Long cid, Integer problemType, String oj);
}
