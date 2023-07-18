package com.github.loj.controller.oj;

import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.discussion.Comment;
import com.github.loj.pojo.vo.CommentListVO;
import com.github.loj.pojo.vo.CommentVO;
import com.github.loj.service.oj.CommentService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:04
 */
@RestController
@RequestMapping("api")
public class CommentController {

    @Autowired
    private CommentService commentService;

    /**
     * 获取评论列表
     * @param cid
     * @param did
     * @param limit
     * @param currentPage
     * @return
     */
    @GetMapping("/comments")
    @AnonApi
    public CommonResult<CommentListVO> getComments(@RequestParam(value = "cid", required = false) Long cid,
                                                   @RequestParam(value = "did", required = false) Integer did,
                                                   @RequestParam(value = "limit", required = false, defaultValue = "20") Integer limit,
                                                   @RequestParam(value = "currentPage", required = false, defaultValue = "1") Integer currentPage) {

        return commentService.getComments(cid, did, limit, currentPage);
    }

    @PostMapping("/comment")
    @RequiresPermissions("comment_add")
    @RequiresAuthentication
    public CommonResult<CommentVO> addComment(@RequestBody Comment comment) {
        return commentService.addComment(comment);
    }

    @DeleteMapping("/comment")
    @RequiresAuthentication
    public CommonResult<Void> deleteComment(@RequestBody Comment comment) {
        return commentService.deleteComment(comment);
    }

    @GetMapping("/comment-like")
    @RequiresAuthentication
    public CommonResult<Void> addCommentLike(@RequestParam("cid") Integer cid,
                                             @RequestParam("toLike") Boolean toLike,
                                             @RequestParam("sourceId") Integer sourceId,
                                             @RequestParam("sourceType") String sourceType) {
        return commentService.addCommentLike(cid, toLike, sourceId, sourceType);
    }

}
