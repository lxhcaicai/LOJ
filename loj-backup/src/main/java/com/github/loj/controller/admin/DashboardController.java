package com.github.loj.controller.admin;

import com.github.loj.service.admin.system.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author lxhcaicai
 * @date 2023/4/26 22:20
 */
@RestController
@RequestMapping("/api/admin/dashboard")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;
}
