package com.github.loj.manager.admin.discussion;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.pojo.entity.discussion.Discussion;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Slf4j(topic = "loj")
public class AdminDiscussionManager {

    @Autowired
    private DiscussionEntityService discussionEntityService;

    public void updateDiscussion(Discussion discussion) throws StatusFailException {
        boolean isOk = discussionEntityService.updateById(discussion);
        if(!isOk) {
            throw new StatusFailException("修改失败");
        }
    }

}
