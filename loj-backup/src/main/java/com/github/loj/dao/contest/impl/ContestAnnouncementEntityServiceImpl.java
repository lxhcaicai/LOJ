package com.github.loj.dao.contest.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestAnnouncementEntityService;
import com.github.loj.mapper.ContestAnnouncementMapper;
import com.github.loj.pojo.entity.contest.ContestAnnouncement;
import org.springframework.stereotype.Service;

@Service
public class ContestAnnouncementEntityServiceImpl extends ServiceImpl<ContestAnnouncementMapper, ContestAnnouncement> implements ContestAnnouncementEntityService {
}
