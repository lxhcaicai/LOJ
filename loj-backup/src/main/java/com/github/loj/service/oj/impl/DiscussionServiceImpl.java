package com.github.loj.service.oj.impl;

import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.DiscussionManager;
import com.github.loj.pojo.entity.problem.Category;
import com.github.loj.service.oj.DiscussionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/27 23:45
 */
@Service
public class DiscussionServiceImpl implements DiscussionService {

    @Resource
    private DiscussionManager discussionManager;

    @Override
    public CommonResult<List<Category>> getDiscussionCategory() {
        return CommonResult.successResponse(discussionManager.getDiscussionCategory());
    }
}
