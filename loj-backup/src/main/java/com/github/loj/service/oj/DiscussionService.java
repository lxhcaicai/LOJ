package com.github.loj.service.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.problem.Category;
import com.github.loj.pojo.vo.DiscussionVO;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/27 23:41
 */
public interface DiscussionService {
    public CommonResult<List<Category>> getDiscussionCategory();

    public CommonResult<IPage<Discussion>> getDiscussionList(Integer limit,
                                                             Integer currentPage,
                                                             Integer categoryId,
                                                             String pid,
                                                             Boolean onlyMine,
                                                             String keyword,
                                                             Boolean admin);

    public CommonResult<DiscussionVO> getDiscussion(Integer did);

    public CommonResult<Void> addDiscussion(Discussion discussion);

    public CommonResult<Void> updateDiscussion(Discussion discussion);

    public CommonResult<Void> removeDiscussion(Integer did);
}
