package com.github.loj.service.admin.system;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.user.Session;

import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/4/26 22:22
 */
public interface DashboardService {

    public CommonResult<Session> getRecentSession();

    public CommonResult<Map<Object,Object>> getDashboardInfo();
}
