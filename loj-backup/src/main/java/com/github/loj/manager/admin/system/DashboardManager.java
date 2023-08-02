package com.github.loj.manager.admin.system;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.dao.user.SessionEntityService;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.pojo.entity.user.Session;
import com.github.loj.shiro.AccountProfile;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

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

    public Session getRecentSession() {
        // 需要获取一下该token对应用户的数据
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        QueryWrapper<Session> wrapper = new QueryWrapper<Session>().eq("uid",userRolesVo.getUid()).orderByDesc("gmt_create");
        List<Session> sessionList = sessionEntityService.list(wrapper);
        if(sessionList.size() > 1) {
            return sessionList.get(1);
        } else {
            return sessionList.get(0);
        }
    }
}
