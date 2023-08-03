package com.github.loj.dao.discussion.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.discussion.DiscussionReportEntityService;
import com.github.loj.mapper.DiscussionReportMapper;
import com.github.loj.pojo.entity.discussion.DiscussionReport;
import com.github.loj.pojo.vo.DiscussionReportVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class DiscussionReportEntityServiceImpl extends ServiceImpl<DiscussionReportMapper,DiscussionReport> implements DiscussionReportEntityService {

    @Resource
    private DiscussionReportMapper discussionReportMapper;

    @Override
    public IPage<DiscussionReportVO> getDiscussionReportList(Integer limit, Integer currentPage) {
        Page<DiscussionReportVO> page = new Page<>(currentPage, limit);
        return discussionReportMapper.getDiscussionReportList(page);
    }
}
