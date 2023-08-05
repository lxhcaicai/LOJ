package com.github.loj.service.admin.contest;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.problem.Problem;

import java.util.HashMap;
import java.util.Map;

public interface AdminContestProblemService {

    public CommonResult<HashMap<String,Object>> getProblemList(Integer limit, Integer currentPage, String keyword,
                                                               Long cid, Integer problemType, String oj);

    public CommonResult<Problem> getProblem(Long pid);

    public CommonResult<Void> deleteProblem(Long pid, Long cid);

    public CommonResult<Map<Object,Object>> addProblem(ProblemDTO problemDTO);
}
