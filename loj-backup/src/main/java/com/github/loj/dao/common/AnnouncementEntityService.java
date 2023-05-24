package com.github.loj.dao.common;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.common.Announcement;
import com.github.loj.pojo.vo.AnnouncementVO;

/**
 * @author lxhcaicai
 * @date 2023/5/15 19:52
 */
public interface AnnouncementEntityService extends IService<Announcement> {
    IPage<AnnouncementVO> getAnnouncementList(int limit, int currentPage, Boolean notAdmin);

    IPage<AnnouncementVO> getContestAnnouncement(Long cid, Boolean notAdmin, int limit, int currentPage);
}
