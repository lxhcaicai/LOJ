package com.github.loj.service.oj.impl;

import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.CommonManager;
import com.github.loj.pojo.vo.CaptchaVO;
import com.github.loj.service.oj.CommonService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

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
}
