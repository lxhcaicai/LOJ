package com.github.loj.controller.oj;

import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.problem.Language;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.pojo.entity.training.TrainingCategory;
import com.github.loj.pojo.vo.CaptchaVO;
import com.github.loj.pojo.vo.ProblemTagVO;
import com.github.loj.service.oj.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collection;
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

    /**
     * 获取训练分类
     * @return
     */
    @GetMapping("/get-training-category")
    @AnonApi
    public CommonResult<List<TrainingCategory>> getTrainingCategory() {
        return commonService.getTrainingCategory();
    }

    @GetMapping("/languages")
    @AnonApi
    public CommonResult<List<Language>> getLanguages(@RequestParam(value = "pid", required = false) Long pid,
                                                     @RequestParam(value = "all", required = false) Boolean all) {
        return commonService.getLanguages(pid, all);
    }

    @GetMapping("/get-problem-tags")
    @AnonApi
    public CommonResult<Collection<Tag>> getProblemTags(Long pid) {
        return commonService.getProblemTags(pid);
    }

}
