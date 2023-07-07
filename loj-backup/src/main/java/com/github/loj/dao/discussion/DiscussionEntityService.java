package com.github.loj.dao.discussion;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.vo.DiscussionVO;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:42
 */
public interface DiscussionEntityService extends IService<Discussion> {
    DiscussionVO getDiscussion(Integer did, String uid);

    void updatePostLikeMsg(String recipientId, String senderId, Integer discussionId, Long gid);
}
