package com.github.loj.dao.discussion;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.discussion.Reply;

public interface ReplyEntityService extends IService<Reply> {

    public void updateReplyMsg(Integer sourceId, String sourceType, String content,
                               Integer quoteId, String quoteType, String recipientId, String senderId);
}
