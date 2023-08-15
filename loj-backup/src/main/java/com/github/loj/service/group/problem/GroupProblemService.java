package com.github.loj.service.group.problem;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.problem.ProblemCase;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.pojo.vo.ProblemVO;

import java.util.List;

public interface GroupProblemService {
    public CommonResult<IPage<ProblemVO>> getProblemList(Integer limit, Integer currentPage, Long gid);

    public CommonResult<IPage<Problem>> getAdminProblemList(Integer limit, Integer currentPage, Long gid);

    public CommonResult<Problem> getProblem(Long pid);

    public CommonResult<Problem> addProblem(ProblemDTO problemDTO);

    public CommonResult<Problem> updateProblem(ProblemDTO problemDTO);

    public CommonResult<Void> deleteProblem(Long pid);

    public CommonResult<List<ProblemCase>> getProblemCases(Long pid, Boolean isUpload);

    public CommonResult<List<Tag>> getAllProblemTagList(Long gid);

    public CommonResult<Void> changeProblemAuth(Long pid, Integer auth);

    public CommonResult<Void> applyPublic(Long pid, Boolean isApplied);
}
