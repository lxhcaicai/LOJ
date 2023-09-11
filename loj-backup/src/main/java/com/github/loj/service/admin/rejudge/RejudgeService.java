package com.github.loj.service.admin.rejudge;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.judge.Judge;

public interface RejudgeService {
    CommonResult<Judge> rejudge(Long submitId);
}
