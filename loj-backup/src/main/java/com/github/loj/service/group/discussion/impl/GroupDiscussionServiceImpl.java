package com.github.loj.service.group.discussion.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.group.discussion.GroupDiscussionManager;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.service.group.discussion.GroupDiscussionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GroupDiscussionServiceImpl implements GroupDiscussionService {

    @Autowired
    private GroupDiscussionManager groupDiscussionManager;

    @Override
    public CommonResult<IPage<Discussion>> getDiscussionList(Integer limit, Integer currentPage, Long gid, String pid) {
        try {
            return CommonResult.successResponse(groupDiscussionManager.getDiscussionList(limit,currentPage,gid,pid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        }
    }
}
