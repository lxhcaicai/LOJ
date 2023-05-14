package com.github.loj.manager.msg;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.dao.msg.AdminSysNoticeEntityService;
import com.github.loj.dao.msg.UserSysNoticeEntityService;
import com.github.loj.pojo.entity.msg.AdminSysNotice;
import com.github.loj.pojo.entity.msg.UserSysNotice;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/14 12:02
 */
@Component
public class NoticeManager {

    @Resource
    private AdminSysNoticeEntityService adminSysNoticeEntityService;

    @Resource
    private UserSysNoticeEntityService userSysNoticeEntityService;

    @Async
    public void syncNoticeToNewRegisterUser(String uid) {
        QueryWrapper<AdminSysNotice> adminSysNoticeQueryWrapper = new QueryWrapper<>();
        adminSysNoticeQueryWrapper
                .eq("type", "All")
                .le("gmt_create", new Date())
                .eq("state", true);
        List<AdminSysNotice> adminSysNotices = adminSysNoticeEntityService.list(adminSysNoticeQueryWrapper);

        if(adminSysNotices.size() == 0) {
            return;
        }
        List<UserSysNotice> userSysNoticeList = new ArrayList<>();
        for(AdminSysNotice adminSysNotice: adminSysNotices) {
            UserSysNotice userSysNotice = new UserSysNotice();
            userSysNotice.setType("Sys")
                    .setSysNoticeId(adminSysNotice.getId())
                    .setRecipientId(uid);
            userSysNoticeList.add(userSysNotice);
        }
        userSysNoticeEntityService.saveOrUpdateBatch(userSysNoticeList);
    }

}
