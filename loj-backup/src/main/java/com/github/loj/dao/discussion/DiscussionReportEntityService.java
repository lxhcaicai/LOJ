package com.github.loj.dao.discussion;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.discussion.DiscussionReport;
import com.github.loj.pojo.vo.DiscussionReportVO;

public interface DiscussionReportEntityService extends IService<DiscussionReport> {

    IPage<DiscussionReportVO> getDiscussionReportList(Integer limit, Integer currentPage);
}
