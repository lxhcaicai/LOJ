package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ReplyDTO;
import com.github.loj.pojo.entity.discussion.Comment;
import com.github.loj.pojo.vo.CommentListVO;
import com.github.loj.pojo.vo.CommentVO;
import com.github.loj.pojo.vo.ReplyVO;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:08
 */
public interface CommentService {

    public CommonResult<CommentListVO> getComments(Long cid, Integer did, Integer limit, Integer currentPage);

    public CommonResult<CommentVO> addComment(Comment comment);

    public CommonResult<Void> addCommentLike(Integer cid, Boolean toLike, Integer sourceId, String sourceType);

    public CommonResult<Void> deleteComment(Comment comment);

    public CommonResult<ReplyVO> addReply(ReplyDTO replyDTO);

    public CommonResult<Void> deleteReply(ReplyDTO replyDTO);

    public CommonResult<List<ReplyVO>> getAllReply(Integer commentId, Long cid);
}
