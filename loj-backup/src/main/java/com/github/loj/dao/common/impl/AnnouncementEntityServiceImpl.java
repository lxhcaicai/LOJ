package com.github.loj.dao.common.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.common.AnnouncementEntityService;
import com.github.loj.mapper.AnnouncementMapper;
import com.github.loj.pojo.entity.common.Announcement;
import com.github.loj.pojo.vo.AnnouncementVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/15 19:53
 */
@Service
public class AnnouncementEntityServiceImpl extends ServiceImpl<AnnouncementMapper,Announcement>implements AnnouncementEntityService {

    @Autowired
    private AnnouncementMapper announcementMapper;

    @Override
    public IPage<AnnouncementVO> getAnnouncementList(int limit, int currentPage, Boolean notAdmin) {
        Page<AnnouncementVO> page = new Page<>(currentPage, limit);
        return announcementMapper.getAnnouncementList(page, notAdmin);
    }

    @Override
    public IPage<AnnouncementVO> getContestAnnouncement(Long cid, Boolean notAdmin, int limit, int currentPage) {
        Page<AnnouncementVO> page = new Page<>(currentPage, limit);
        return announcementMapper.getContestAnnouncement(page, cid, notAdmin);
    }
}
