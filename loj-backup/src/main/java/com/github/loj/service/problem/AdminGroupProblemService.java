package com.github.loj.service.problem;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ChangeGroupProblemProgressDTO;
import com.github.loj.pojo.entity.problem.Problem;

public interface AdminGroupProblemService {
    public CommonResult<IPage<Problem>> getProblemList(Integer currentPage, Integer limit, String keyword, Long gid);

    public CommonResult<Void> changeProgress(ChangeGroupProblemProgressDTO changeGroupProblemProgressDTO);
}
