package com.github.loj.service.oj.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.TrainingManager;
import com.github.loj.pojo.vo.TrainingVO;
import com.github.loj.service.oj.TrainingService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/16 22:12
 */
@Service
public class TrainingServiceImpl implements TrainingService {

    @Resource
    private TrainingManager trainingManager;

    @Override
    public CommonResult<IPage<TrainingVO>> getTrainingList(Integer limit, Integer currentPage, String keyword, Long categoryId, String auth) {
        return CommonResult.successResponse(trainingManager.getTrainingList(limit, currentPage, keyword, categoryId, auth));
    }
}
