package com.github.loj.dao.discussion.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.discussion.DiscussionReportEntityService;
import com.github.loj.mapper.DiscussionReportMapper;
import com.github.loj.pojo.entity.discussion.DiscussionReport;
import org.springframework.stereotype.Service;

@Service
public class DiscussionReportEntityServiceImpl extends ServiceImpl<DiscussionReportMapper,DiscussionReport> implements DiscussionReportEntityService {
}
