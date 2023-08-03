package com.github.loj.service.admin.discussion.impl;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.discussion.AdminDiscussionManager;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.discussion.DiscussionReport;
import com.github.loj.pojo.vo.DiscussionReportVO;
import com.github.loj.service.admin.discussion.AdminDiscussionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminDiscussionServiceImpl implements AdminDiscussionService {

    @Autowired
    private AdminDiscussionManager adminDiscussionManager;

    @Override
    public CommonResult<Void> updateDiscussion(Discussion discussion) {
        try {
            adminDiscussionManager.updateDiscussion(discussion);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> removeDiscussion(List<Integer> didList) {
        try {
            adminDiscussionManager.removeDiscussion(didList);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<IPage<DiscussionReportVO>> getDiscussionReport(Integer limit, Integer currentPage) {
        IPage<DiscussionReportVO> discussionReportIPage = adminDiscussionManager.getDiscussionReport(limit, currentPage);
        return CommonResult.successResponse(discussionReportIPage);
    }

    @Override
    public CommonResult<Void> updateDiscussionReport(DiscussionReport discussionReport) {
        try {
            adminDiscussionManager.updateDiscussionReport(discussionReport);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
