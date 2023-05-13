package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.CaptchaVO;

/**
 * @author lxhcaicai
 * @date 2023/5/13 20:14
 */
public interface CommonService {

    public CommonResult<CaptchaVO> getCaptcha();

}
