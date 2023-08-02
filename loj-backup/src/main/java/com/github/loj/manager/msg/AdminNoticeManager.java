package com.github.loj.manager.msg;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.msg.AdminSysNoticeEntityService;
import com.github.loj.dao.msg.UserSysNoticeEntityService;
import com.github.loj.pojo.entity.msg.AdminSysNotice;
import com.github.loj.pojo.entity.msg.UserSysNotice;
import com.github.loj.pojo.vo.AdminSysNoticeVO;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/6 0:48
 */
@Component
public class AdminNoticeManager {
    @Resource
    private AdminSysNoticeEntityService adminSysNoticeEntityService;

    @Resource
    private UserSysNoticeEntityService userSysNoticeEntityService;

    public IPage<AdminSysNoticeVO> getSysNotice(Integer limit, Integer currentPage, String type) {

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 5;
        }
        return adminSysNoticeEntityService.getSysNotice(limit, currentPage, type);
    }

    public void addSysNotice(AdminSysNotice adminSysNotice) throws StatusFailException {
        boolean isOk = adminSysNoticeEntityService.saveOrUpdate(adminSysNotice);
        if(!isOk) {
            throw new StatusFailException("发布失败");
        }
    }

    public void deleteSysNotice(Long id) throws StatusFailException {
        boolean isOk = adminSysNoticeEntityService.removeById(id);
        if(!isOk) {
            throw new StatusFailException("删除失败");
        }
    }

    public void updateSysNotice(AdminSysNotice adminSysNotice) throws StatusFailException {
        boolean isOk = adminSysNoticeEntityService.saveOrUpdate(adminSysNotice);
        if(!isOk) {
            throw new StatusFailException("更新失败");
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Async
    public void addSingleNoticeToUser(String adminId, String recipienId, String title, String content, String type) {
        AdminSysNotice adminSysNotice = new AdminSysNotice();
        adminSysNotice.setAdminId(adminId)
                .setType("Single")
                .setTitle(title)
                .setContent(content)
                .setState(true)
                .setRecipientId(recipienId);

        boolean isOk = adminSysNoticeEntityService.save(adminSysNotice);
        if(isOk) {
            UserSysNotice userSysNotice = new UserSysNotice();
            userSysNotice.setRecipientId(recipienId)
                    .setSysNoticeId(adminSysNotice.getId())
                    .setType(type);
            userSysNoticeEntityService.save(userSysNotice);
        }
    }

    @Async
    public void syncNoticeToNewRegisterBatchUser(List<String> uidList) {
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
        for(String uid: uidList) {
            for(AdminSysNotice adminSysNotice: adminSysNotices) {
                UserSysNotice userSysNotice = new UserSysNotice();
                userSysNotice.setType("Sys")
                        .setSysNoticeId(adminSysNotice.getId())
                        .setRecipientId(uid);
                userSysNoticeList.add(userSysNotice);
            }
        }
        userSysNoticeEntityService.saveOrUpdateBatch(userSysNoticeList);
    }

    @Transactional(rollbackFor = Exception.class)
    @Async
    public void addSingleNoticeToBatchUser(String adminId,
                                           List<String> recipientIdList,
                                           String title,
                                           String content,
                                           String type) {
        if(CollectionUtils.isEmpty(recipientIdList)) {
            return;
        }
        AdminSysNotice adminSysNotice = new AdminSysNotice();
        adminSysNotice.setAdminId(adminId)
                .setType("Single")
                .setTitle(title)
                .setContent(content)
                .setState(true);

        boolean isOk = adminSysNoticeEntityService.save(adminSysNotice);

        if(isOk) {
            List<UserSysNotice> userSysNoticeList = new ArrayList<>();
            for(String recipientId: recipientIdList) {
                UserSysNotice userSysNotice = new UserSysNotice();
                userSysNotice.setRecipientId(recipientId)
                        .setSysNoticeId(adminSysNotice.getId())
                        .setType(type);
                userSysNoticeList.add(userSysNotice);
            }
            userSysNoticeEntityService.saveBatch(userSysNoticeList);
        }
    }

}
