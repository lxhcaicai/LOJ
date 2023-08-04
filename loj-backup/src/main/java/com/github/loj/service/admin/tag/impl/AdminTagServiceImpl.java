package com.github.loj.service.admin.tag.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.tag.AdminTagManager;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.service.admin.tag.AdminTagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminTagServiceImpl implements AdminTagService {

    @Autowired
    private AdminTagManager adminTagManager;
    @Override
    public CommonResult<Tag> addTag(Tag tag) {
        try {
            return CommonResult.successResponse(adminTagManager.addTag(tag));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> updateTag(Tag tag) {
        try {
            adminTagManager.updateTag(tag);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
