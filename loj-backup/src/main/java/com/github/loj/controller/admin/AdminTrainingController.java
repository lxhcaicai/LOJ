package com.github.loj.controller.admin;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.TrainingDTO;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.service.admin.training.AdminTrainingService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;

@RestController
@RequestMapping("/api/admin/training")
public class AdminTrainingController {

    @Resource
    private AdminTrainingService adminTrainingService;

    @GetMapping("/get-training-list")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<IPage<Training>> getTrainingList(@RequestParam(value = "limit", required = false) Integer limit,
                                                     @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                     @RequestParam(value = "keyword", required = false) String keyword) {
        return adminTrainingService.getTrainingList(limit, currentPage, keyword);
    }

    @GetMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<TrainingDTO> getTraining(@RequestParam("tid") Long tid) {
        return adminTrainingService.getTraining(tid);
    }

    @DeleteMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = "root") // 只有超级管理员能删除训练
    public CommonResult<Void> deleteTraining(@RequestParam("tid") Long tid) {
        return adminTrainingService.deleteTraining(tid);
    }

    @PostMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> addTraining(@RequestBody TrainingDTO trainingDTO) {
        return adminTrainingService.addTraining(trainingDTO);
    }

    @PutMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> updateTraining(@RequestBody TrainingDTO trainingDTO) {
        return adminTrainingService.updateTraining(trainingDTO);
    }


    @PutMapping("/change-training-status")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> changeTrainingStatus(@RequestParam(value = "tid", required = true) Long tid,
                                                   @RequestParam(value = "author", required = true) String author,
                                                   @RequestParam(value = "status", required = true) Boolean status) {
        return adminTrainingService.changeTrainingStatus(tid, author, status);
    }
}
