package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.discussion.Comment;
import com.github.loj.pojo.vo.CommentListVO;
import com.github.loj.pojo.vo.CommentVO;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:08
 */
public interface CommentService {

    public CommonResult<CommentListVO> getComments(Long cid, Integer did, Integer limit, Integer currentPage);

    public CommonResult<CommentVO> addComment(Comment comment);
}
