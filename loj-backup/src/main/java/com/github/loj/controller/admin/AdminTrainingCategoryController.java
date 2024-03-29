package com.github.loj.controller.admin;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.training.TrainingCategory;
import com.github.loj.service.admin.training.AdminTrainingCategoryService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/api/admin/training/category")
public class AdminTrainingCategoryController {

    @Resource
    private AdminTrainingCategoryService adminTrainingCategoryService;

    /**
     * 添加训练标签
     * @param trainingCategory 训练分类
     * @return
     */
    @PostMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","problem_admin"}, logical = Logical.OR)
    public CommonResult<TrainingCategory> addTrainingCategory(@RequestBody TrainingCategory trainingCategory) {
        return adminTrainingCategoryService.addTrainingCategory(trainingCategory);
    }

    @PutMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> updateTrainingCategory(@RequestBody TrainingCategory trainingCategory) {
        return adminTrainingCategoryService.updateTrainingCategory(trainingCategory);
    }

    @DeleteMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> deleteTrainingCategory(@RequestParam("cid") Long cid) {
        return adminTrainingCategoryService.deleteTrainingCategory(cid);
    }
}
