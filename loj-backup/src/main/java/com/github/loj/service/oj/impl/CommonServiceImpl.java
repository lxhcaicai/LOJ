package com.github.loj.service.oj.impl;

import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.CommonManager;
import com.github.loj.pojo.entity.training.TrainingCategory;
import com.github.loj.pojo.vo.CaptchaVO;
import com.github.loj.pojo.vo.ProblemTagVO;
import com.github.loj.service.oj.CommonService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/13 20:14
 */
@Service
public class CommonServiceImpl implements CommonService {

    @Resource
    private CommonManager commonManager;

    @Override
    public CommonResult<CaptchaVO> getCaptcha() {
        return CommonResult.successResponse(commonManager.getCaptcha());
    }

    @Override
    public CommonResult<List<ProblemTagVO>> getProblemTagsAndClassification(String oj) {
        return CommonResult.successResponse(commonManager.getProblemTagsAndClassification(oj));
    }

    @Override
    public CommonResult<List<TrainingCategory>> getTrainingCategory() {
        return CommonResult.successResponse(commonManager.getTrainingCategory());
    }
}
