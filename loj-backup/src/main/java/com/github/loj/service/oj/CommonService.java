package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.training.TrainingCategory;
import com.github.loj.pojo.vo.CaptchaVO;
import com.github.loj.pojo.vo.ProblemTagVO;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/13 20:14
 */
public interface CommonService {

    public CommonResult<CaptchaVO> getCaptcha();

    public CommonResult<List<ProblemTagVO>> getProblemTagsAndClassification(String oj);

    public CommonResult<List<TrainingCategory>> getTrainingCategory();

}
