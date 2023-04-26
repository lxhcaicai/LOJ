package com.github.loj.manager.admin.system;

import com.github.loj.dao.user.SessionEntityService;
import com.github.loj.dao.user.UserInfoEntityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @author lxhcaicai
 * @date 2023/4/26 22:27
 */
@Component
public class DashboardManager {
    @Autowired
    private UserInfoEntityService userInfoEntityService;

    @Autowired
    private SessionEntityService sessionEntityService;
}
