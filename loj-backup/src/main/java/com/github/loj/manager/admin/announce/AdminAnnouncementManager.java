package com.github.loj.manager.admin.announce;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.dao.common.AnnouncementEntityService;
import com.github.loj.pojo.vo.AnnouncementVO;
import lombok.extern.slf4j.Slf4j;
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
}
