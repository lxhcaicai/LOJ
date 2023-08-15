package com.github.loj.service.group.problem;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ProblemVO;

public interface GroupProblemService {
    public CommonResult<IPage<ProblemVO>> getProblemList(Integer limit, Integer currentPage, Long gid);

    public CommonResult<IPage<Problem>> getAdminProblemList(Integer limit, Integer currentPage, Long gid);

    public CommonResult<Problem> getProblem(Long pid);
}
