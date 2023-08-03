package com.github.loj.service.admin.discussion;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.discussion.Discussion;

public interface AdminDiscussionService {

    public CommonResult<Void> updateDiscussion(Discussion discussion);
}
