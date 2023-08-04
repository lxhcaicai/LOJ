package com.github.loj.controller.admin;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.service.admin.tag.AdminTagService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/api/admin/tag")
public class AdminTagController {

    @Resource
    private AdminTagService adminTagService;

    @PostMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","problem_admin"},logical = Logical.OR)
    public CommonResult<Tag> addTag(@RequestBody Tag tag) {
        return adminTagService.addTag(tag);
    }

    @PutMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","problem_admin"},logical = Logical.OR)
    public CommonResult<Void> updateTag(@RequestBody Tag tag) {
        return adminTagService.updateTag(tag);
    }

}
