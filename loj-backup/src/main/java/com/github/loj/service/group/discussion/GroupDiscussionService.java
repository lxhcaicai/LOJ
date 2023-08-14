package com.github.loj.service.group.discussion;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.discussion.Discussion;

public interface GroupDiscussionService {
    public CommonResult<IPage<Discussion>> getDiscussionList(Integer limit, Integer currentPage, Long gid, String pid);

    public CommonResult<IPage<Discussion>> getAdminDiscussionList(Integer limit, Integer currentPage, Long gid);

    public CommonResult<Void> addDiscussion(Discussion discussion);

    public CommonResult<Void> updateDiscussion(Discussion discussion);
}
