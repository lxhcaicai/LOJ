package com.github.loj.controller.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.dao.training.TrainingEntityService;
import com.github.loj.pojo.dto.RegisterTrainingDTO;
import com.github.loj.pojo.vo.AccessVO;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.pojo.vo.TrainingRankVO;
import com.github.loj.pojo.vo.TrainingVO;
import com.github.loj.service.oj.TrainingService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/16 22:03
 */
@RestController
@RequestMapping("/api")
public class TrainingController {

    @Resource
    private TrainingService trainingService;

    /**
     * 获取训练题单列表，可根据关键词、类别、权限、类型过滤
     * @param limit
     * @param currentPage
     * @param keyword
     * @param categoryId
     * @param auth
     * @return
     */
    @GetMapping("/get-training-list")
    @AnonApi
    public CommonResult<IPage<TrainingVO>> getTrainingList(@RequestParam(value = "limit", required = false) Integer limit,
                                                           @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                           @RequestParam(value = "keyword", required = false) String keyword,
                                                           @RequestParam(value = "category", required = false) Long categoryId,
                                                           @RequestParam(value = "auth", required = false) String auth) {

        return trainingService.getTrainingList(limit, currentPage, keyword, categoryId, auth);
    }


    /**
     * 根据tid获取指定训练的题单题目列表
     * @param tid
     * @return
     */
    @GetMapping("/get-training-detail")
    @RequiresAuthentication
    public CommonResult<TrainingVO> getTraining(@RequestParam(value = "tid") Long tid) {
        return trainingService.getTraining(tid);
    }

    /**
     * 私有权限的训练需要获取当前用户是否有进入训练的权限
     * @param tid
     * @return
     */
    @RequiresAuthentication
    @GetMapping("/get-training-access")
    public CommonResult<AccessVO> getTrainingAccess(@RequestParam(value = "tid") Long tid) {
        return trainingService.getTrainingAccess(tid);
    }


    /**
     * 根据tid获取指定训练的题单题目列表
     * @param tid
     * @return
     */
    @GetMapping("/get-training-problem-list")
    @RequiresAuthentication
    public CommonResult<List<ProblemVO>> getTrainingProblemList(@RequestParam(value = "tid") Long tid) {
        return trainingService.getTrainingProblemList(tid);
    }

    /**
     * 注册校验私有权限的训练
     * @param registerTrainingDTO
     * @return
     */
    @PostMapping("/register-training")
    @RequiresAuthentication
    public CommonResult<Void> toRegisterTraining(@RequestBody RegisterTrainingDTO registerTrainingDTO) {
        return trainingService.toRegisterTraining(registerTrainingDTO);
    }

    /**
     * 获取训练的排行榜分页
     * @param tid
     * @param limit
     * @param currentPage
     * @param keyword
     * @return
     */
    @GetMapping("/get-training-rank")
    @RequiresAuthentication
    public CommonResult<IPage<TrainingRankVO>> getTrainingRank(@RequestParam(value = "tid", required = true) Long tid,
                                                               @RequestParam(value = "limit", required = false)Integer limit,
                                                               @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                               @RequestParam(value = "keyword", required = false) String keyword) {
        return trainingService.getTrainingRank(tid,limit,currentPage,keyword);
    }
}
