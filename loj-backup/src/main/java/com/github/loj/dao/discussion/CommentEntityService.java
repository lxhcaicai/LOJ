package com.github.loj.dao.discussion;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.discussion.Comment;
import com.github.loj.pojo.vo.CommentVO;

/**
 * @author lxhcaicai
 * @date 2023/5/25 1:01
 */
public interface CommentEntityService extends IService<Comment> {

    IPage<CommentVO> getCommentList(int limit, int currentPage, Long cid, Integer did, Boolean isRoot, String uid);
}
