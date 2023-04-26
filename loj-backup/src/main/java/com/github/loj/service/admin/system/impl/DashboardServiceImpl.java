package com.github.loj.service.admin.system.impl;

import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.system.DashboardManager;
import com.github.loj.pojo.entity.user.Session;
import com.github.loj.service.admin.system.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/4/26 22:24
 */
@Service
public class DashboardServiceImpl implements DashboardService {

    @Autowired
    private DashboardManager dashboardManager;

    @Override
    public CommonResult<Session> getRecentSession() {
        return null;
    }

    @Override
    public CommonResult<Map<Object, Object>> getDashboardInfo() {
        return null;
    }
}
