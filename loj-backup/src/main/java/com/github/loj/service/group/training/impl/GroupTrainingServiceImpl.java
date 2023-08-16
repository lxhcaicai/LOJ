package com.github.loj.service.group.training.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.group.training.GroupTrainingManager;
import com.github.loj.pojo.dto.TrainingDTO;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.vo.TrainingVO;
import com.github.loj.service.group.training.GroupTrainingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GroupTrainingServiceImpl implements GroupTrainingService {

    @Autowired
    private GroupTrainingManager groupTrainingManager;

    @Override
    public CommonResult<IPage<TrainingVO>> getTrainingList(Integer limit, Integer currentPage, Long gid) {
        try {
            return CommonResult.successResponse(groupTrainingManager.getTrainingList(limit,currentPage,gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<IPage<Training>> getAdminTrainingList(Integer limit, Integer currentPage, Long gid) {
        try {
            return CommonResult.successResponse(groupTrainingManager.getAdminTrainingList(limit,currentPage,gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<TrainingDTO> getTraining(Long tid) {
        try {
            return CommonResult.successResponse(groupTrainingManager.getTraining(tid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        }
    }
}
