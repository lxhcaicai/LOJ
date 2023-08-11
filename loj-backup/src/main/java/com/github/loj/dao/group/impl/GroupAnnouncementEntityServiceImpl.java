package com.github.loj.dao.group.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.group.GroupAnnouncementEntityService;
import com.github.loj.mapper.GroupAnnouncementMapper;
import com.github.loj.pojo.entity.common.Announcement;
import com.github.loj.pojo.vo.AnnouncementVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GroupAnnouncementEntityServiceImpl extends ServiceImpl<GroupAnnouncementMapper, Announcement> implements GroupAnnouncementEntityService {

    @Autowired
    private GroupAnnouncementMapper groupAnnouncementMapper;

    @Override
    public IPage<AnnouncementVO> getAnnouncementList(int limit, int currentPage, Long gid) {
        IPage<AnnouncementVO> iPage = new Page<>(currentPage, limit);

        List<AnnouncementVO> announcementList = groupAnnouncementMapper.getAnnouncementList(iPage, gid);

        return iPage.setRecords(announcementList);
    }

    @Override
    public IPage<AnnouncementVO> getAdminAnnouncementList(Integer limit, Integer currentPage, Long gid) {
        IPage<AnnouncementVO> iPage = new Page<>(currentPage, limit);

        List<AnnouncementVO> announcementList = groupAnnouncementMapper.getAdminAnnouncementList(iPage, gid);

        return iPage.setRecords(announcementList);
    }
}
