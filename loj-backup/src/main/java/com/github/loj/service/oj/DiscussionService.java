package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.problem.Category;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/27 23:41
 */
public interface DiscussionService {
    public CommonResult<List<Category>> getDiscussionCategory();
}
