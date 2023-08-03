package com.github.loj.service.admin.discussion;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.discussion.Discussion;

import java.util.List;

public interface AdminDiscussionService {

    public CommonResult<Void> updateDiscussion(Discussion discussion);

    public CommonResult<Void> removeDiscussion(List<Integer> didList);
}
