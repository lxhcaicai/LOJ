package com.github.loj.service.group.training;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.TrainingVO;

public interface GroupTrainingService {
    public CommonResult<IPage<TrainingVO>> getTrainingList(Integer limit, Integer currentPage, Long gid);
}
