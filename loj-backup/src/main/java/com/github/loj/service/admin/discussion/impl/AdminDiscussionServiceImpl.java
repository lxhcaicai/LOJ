package com.github.loj.service.admin.discussion.impl;


import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.discussion.AdminDiscussionManager;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.service.admin.discussion.AdminDiscussionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
