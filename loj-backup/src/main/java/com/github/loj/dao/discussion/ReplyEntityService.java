package com.github.loj.dao.discussion;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.discussion.Reply;
import com.github.loj.pojo.vo.ReplyVO;

import java.util.List;

public interface ReplyEntityService extends IService<Reply> {

    public void updateReplyMsg(Integer sourceId, String sourceType, String content,
                               Integer quoteId, String quoteType, String recipientId, String senderId);

    public List<ReplyVO> getAllReplyByCommentId(Long cid, String uid, Boolean isRoot, Integer commentId);
}
