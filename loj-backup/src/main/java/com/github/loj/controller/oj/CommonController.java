package com.github.loj.controller.oj;

import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.CaptchaVO;
import com.github.loj.pojo.vo.ProblemTagVO;
import com.github.loj.service.oj.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/13 20:10
 */
@RestController
@RequestMapping("api")
public class CommonController {

    @Autowired
    private CommonService commonService;

    /**
     * 获取算数验证码
     * @return
     */
    @GetMapping("/captcha")
    @AnonApi
    public CommonResult<CaptchaVO> getCaptcha() {
        return commonService.getCaptcha();
    }

    /**
     * 获取题目标签
     * @param oj
     * @return
     */
    @GetMapping("/get-problem-tags-and-classification")
    @AnonApi
    public CommonResult<List<ProblemTagVO>> getProblemTagsAndClassification(@RequestParam(value = "oj", defaultValue = "ME") String oj) {
        return commonService.getProblemTagsAndClassification(oj);
    }

}
