package com.github.loj.service.oj.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.oj.CommentManager;
import com.github.loj.pojo.dto.ReplyDTO;
import com.github.loj.pojo.entity.discussion.Comment;
import com.github.loj.pojo.vo.CommentListVO;
import com.github.loj.pojo.vo.CommentVO;
import com.github.loj.pojo.vo.ReplyVO;
import com.github.loj.service.oj.CommentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.rmi.AccessException;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:08
 */
@Service
public class CommentServiceImpl implements CommentService {

    @Resource
    private CommentManager commentManager;

    @Override
    public CommonResult<CommentListVO> getComments(Long cid, Integer did, Integer limit, Integer currentPage) {
        try {
            return CommonResult.successResponse(commentManager.getComments(cid, did, limit, currentPage));
        } catch (AccessException |  StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        }
    }

    @Override
    public CommonResult<CommentVO> addComment(Comment comment) {
        try {
            return CommonResult.successResponse(commentManager.addComment(comment));
        } catch (StatusForbiddenException | AccessException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException  e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> addCommentLike(Integer cid, Boolean toLike, Integer sourceId, String sourceType) {
        try {
            commentManager.addCommentLike(cid, toLike, sourceId, sourceType);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> deleteComment(Comment comment) {
        try {
            commentManager.deleteComment(comment);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusForbiddenException | AccessException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        }
    }

    @Override
    public CommonResult<ReplyVO> addReply(ReplyDTO replyDTO) {
        try {
            return CommonResult.successResponse(commentManager.addReply(replyDTO));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusForbiddenException | AccessException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        }
    }

    @Override
    public CommonResult<Void> deleteReply(ReplyDTO replyDTO) {
        try {
            commentManager.deleteReply(replyDTO);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusForbiddenException | AccessException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        }
    }

    @Override
    public CommonResult<List<ReplyVO>> getAllReply(Integer commentId, Long cid) {
        try {
            return CommonResult.successResponse(commentManager.getAllReply(commentId, cid));
        } catch (StatusForbiddenException | AccessException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FAIL);
        }
    }
}
