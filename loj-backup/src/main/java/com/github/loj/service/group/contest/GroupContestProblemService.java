package com.github.loj.service.group.contest;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.contest.ContestProblem;

import java.util.HashMap;
import java.util.Map;

public interface GroupContestProblemService {
    public CommonResult<HashMap<String, Object>> getContestProblemList(Integer limit, Integer currentPage, String keyword, Long cid, Integer problemType, String oj);

    public CommonResult<Map<Object, Object>> addProblem(ProblemDTO problemDTO);

    public CommonResult<Void> updateContestProblem(ContestProblem contestProblem);

    public CommonResult<ContestProblem> getContestProblem(Long pid, Long cid);

    public CommonResult<Void> deleteContestProblem(Long pid, Long cid);
}
