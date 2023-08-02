package com.github.loj.controller.admin;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.user.Session;
import com.github.loj.service.admin.system.DashboardService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/4/26 22:20
 */
@RestController
@RequestMapping("/api/admin/dashboard")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @PostMapping("/get-session")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical = Logical.OR)
    public CommonResult<Session> getRecentSession() {
        return dashboardService.getRecentSession();
    }

    @GetMapping("/get-dashboard-info")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical = Logical.OR)
    public CommonResult<Map<Object,Object>> getDashboardInfo() {

        return dashboardService.getDashboardInfo();
    }
}
