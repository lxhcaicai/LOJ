package com.github.loj.service.problem;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.problem.ProblemCase;

import java.util.List;

public interface AdminProblemService {
    public CommonResult<IPage<Problem>> getProblemList(Integer limit, Integer currentPage, String keyword, Integer auth, String oj);

    public CommonResult<Problem> getProblem(Long pid);

    public CommonResult<Void> deleteProblem(Long pid);

    public CommonResult<Void> addProblem(ProblemDTO problemDTO);

    public CommonResult<Void> updateProblem(ProblemDTO problemDTO);

    public CommonResult<List<ProblemCase>> getProblemCases(Long pid, Boolean isUpload);
}
