package com.github.loj.controller.admin;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.service.problem.AdminGroupProblemService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/api/admin/group-problem")
@RequiresAuthentication
@RequiresRoles(value = {"root", "problem_admin"}, logical = Logical.OR)
public class AdminGroupProblemController {
    @Resource
    private AdminGroupProblemService adminGroupProblemService;

    @GetMapping("/list")
    public CommonResult<IPage<Problem>> getProblemList(@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                                                       @RequestParam(value = "limit", defaultValue = "10") Integer limit,
                                                       @RequestParam(value = "keyword", required = false) String keyword,
                                                       @RequestParam(value = "gid", required = false) Long gid) {
        return adminGroupProblemService.getProblemList(currentPage, limit, keyword, gid);
    }
}
