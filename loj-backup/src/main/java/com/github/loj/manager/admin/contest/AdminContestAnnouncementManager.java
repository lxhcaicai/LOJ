package com.github.loj.manager.admin.contest;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.dao.common.AnnouncementEntityService;
import com.github.loj.pojo.vo.AnnouncementVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AdminContestAnnouncementManager {

    @Autowired
    private AnnouncementEntityService announcementEntityService;


    public IPage<AnnouncementVO> getAnnouncementList(Integer limit, Integer currentPage, Long cid) {

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return announcementEntityService.getContestAnnouncement(cid, false, limit, currentPage);
    }
}
