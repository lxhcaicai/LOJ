package com.github.loj.manager.admin.announce;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.common.AnnouncementEntityService;
import com.github.loj.pojo.vo.AnnouncementVO;
import com.github.loj.shiro.AccountProfile;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class AdminAnnouncementManager {

    @Autowired
    private AnnouncementEntityService announcementEntityService;

    public IPage<AnnouncementVO> getAnnouncementList(Integer limit, Integer currentPage) {

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return announcementEntityService.getAnnouncementList(limit,currentPage, false);

    }

    public void deleteAnnouncement(Long aid) throws StatusFailException {
        boolean isOk = announcementEntityService.removeById(aid);
        if(!isOk) {
            throw new StatusFailException("删除失败");
        }
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        log.info("[{}],[{}],id:[{}],operatorUid:[{}],operatorUsername:[{}]",
                "Admin_Announcement", "Delete", aid, userRolesVo.getUid(), userRolesVo.getUsername());
    }
}
