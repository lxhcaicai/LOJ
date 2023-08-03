package com.github.loj.service.admin.discussion;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.discussion.DiscussionReport;
import com.github.loj.pojo.vo.DiscussionReportVO;

import java.util.List;

public interface AdminDiscussionService {

    public CommonResult<Void> updateDiscussion(Discussion discussion);

    public CommonResult<Void> removeDiscussion(List<Integer> didList);

    public CommonResult<IPage<DiscussionReportVO>> getDiscussionReport(Integer limit, Integer currentPage);

    public CommonResult<Void> updateDiscussionReport(DiscussionReport discussionReport);
}
