package com.github.loj.service.admin.training.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.training.AdminTrainingManager;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.service.admin.training.AdminTrainingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminTrainingServiceImpl implements AdminTrainingService {

    @Autowired
    private AdminTrainingManager adminTrainingManager;

    @Override
    public CommonResult<IPage<Training>> getTrainingList(Integer limit, Integer currentPage, String keyword) {
        return CommonResult.successResponse(adminTrainingManager.getTrainingList(limit, currentPage, keyword));
    }
}
