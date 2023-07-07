package com.github.loj.dao.discussion.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.dao.msg.MsgRemindEntityService;
import com.github.loj.mapper.DiscussionMapper;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.msg.MsgRemind;
import com.github.loj.pojo.vo.DiscussionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:42
 */
@Service
public class DiscussionEntityServiceImpl extends ServiceImpl<DiscussionMapper, Discussion> implements DiscussionEntityService {

    @Autowired
    private DiscussionMapper discussionMapper;

    @Resource
    private MsgRemindEntityService msgRemindEntityService;

    @Override
    public DiscussionVO getDiscussion(Integer did, String uid) {
        return discussionMapper.getDiscussion(did, uid);
    }

    @Override
    public void updatePostLikeMsg(String recipientId, String senderId, Integer discussionId, Long gid) {

        MsgRemind msgRemind = new MsgRemind();
        msgRemind.setAction("Like_Post")
                .setRecipientId(recipientId)
                .setSenderId(senderId)
                .setSourceId(discussionId)
                .setSourceType("Discussion")
                .setUrl("/discussion-detail/" + discussionId);

        if(gid != null) {
            msgRemind.setUrl("/group/" + gid + "/discussion-detail/" + discussionId);
        } else {
            msgRemind.setUrl("/discussion-detail/" + discussionId);
        }
        msgRemindEntityService.saveOrUpdate(msgRemind);
    }
}
