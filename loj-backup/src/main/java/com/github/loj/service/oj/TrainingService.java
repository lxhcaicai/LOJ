package com.github.loj.service.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.TrainingVO;

/**
 * @author lxhcaicai
 * @date 2023/5/16 22:11
 */
public interface TrainingService {

    public CommonResult<IPage<TrainingVO>> getTrainingList(Integer limit, Integer currentPage, String keyword, Long categoryId, String auth);

    public CommonResult<TrainingVO> getTraining(Long tid);

}
