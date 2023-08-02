package com.github.loj.manager.msg;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.dao.msg.AdminSysNoticeEntityService;
import com.github.loj.dao.msg.UserSysNoticeEntityService;
import com.github.loj.pojo.entity.msg.AdminSysNotice;
import com.github.loj.pojo.entity.msg.UserSysNotice;
import com.github.loj.pojo.vo.SysMsgVO;
import com.github.loj.shiro.AccountProfile;
import org.apache.shiro.SecurityUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

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

    @Resource
    private ApplicationContext applicationContext;

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

    @Async
    public void updateSysOrMineMsgRead(IPage<SysMsgVO> userMsgList) {
        List<Long> idList = userMsgList.getRecords().stream()
                .filter(userMsgVo -> !userMsgVo.getStatus())
                .map(SysMsgVO::getId)
                .collect(Collectors.toList());

        if(idList.size() == 0) {
            return;
        }
        UpdateWrapper<UserSysNotice> updateWrapper = new UpdateWrapper<>();
        updateWrapper.in("id",idList)
                .set("state", true);
        userSysNoticeEntityService.update(null, updateWrapper);
    }

    public IPage<SysMsgVO> getSysNotice(Integer limit, Integer currentPage) {

        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if (limit == null || limit < 1) {
            limit = 5;
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        IPage<SysMsgVO> sysNotice = userSysNoticeEntityService.getSysNotice(limit,currentPage, userRolesVo.getUid());
        applicationContext.getBean(NoticeManager.class).updateSysOrMineMsgRead(sysNotice);
        return sysNotice;

    }

    public IPage<SysMsgVO> getMineNotice(Integer limit, Integer currentPage) {

        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if (limit == null || limit < 1) {
            limit = 5;
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        IPage<SysMsgVO> mineNotice = userSysNoticeEntityService.getMineNotice(limit,currentPage, userRolesVo.getUid());
        applicationContext.getBean(NoticeManager.class).updateSysOrMineMsgRead(mineNotice);
        return mineNotice;

    }

}
