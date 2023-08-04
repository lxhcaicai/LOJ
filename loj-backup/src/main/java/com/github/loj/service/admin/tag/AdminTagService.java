package com.github.loj.service.admin.tag;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.problem.Tag;

public interface AdminTagService {
    public CommonResult<Tag> addTag(Tag tag);
}
