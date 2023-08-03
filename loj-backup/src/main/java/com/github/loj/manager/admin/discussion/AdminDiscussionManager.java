package com.github.loj.manager.admin.discussion;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.dao.discussion.DiscussionReportEntityService;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.discussion.DiscussionReport;
import com.github.loj.pojo.vo.DiscussionReportVO;
import com.github.loj.shiro.AccountProfile;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@Slf4j(topic = "loj")
public class AdminDiscussionManager {

    @Autowired
    private DiscussionEntityService discussionEntityService;

    @Autowired
    private DiscussionReportEntityService discussionReportEntityService;

    public void updateDiscussion(Discussion discussion) throws StatusFailException {
        boolean isOk = discussionEntityService.updateById(discussion);
        if(!isOk) {
            throw new StatusFailException("修改失败");
        }
    }

    public void removeDiscussion(List<Integer> didList) throws StatusFailException {
        boolean isOk = discussionEntityService.removeByIds(didList);
        if(!isOk) {
            throw new StatusFailException("删除失败");
        }
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        log.info("[{}],[{}],didList:[{}],operatorUid:[{}],operatorUsername:[{}]",
                "Admin_Discussion", "Delete", didList, userRolesVo.getUid(), userRolesVo.getUsername());
    }

    public IPage<DiscussionReportVO> getDiscussionReport(Integer limit, Integer currentPage) {
        return discussionReportEntityService.getDiscussionReportList(limit, currentPage);
    }

    public void updateDiscussionReport(DiscussionReport discussionReport) throws StatusFailException {
        boolean isOk = discussionReportEntityService.updateById(discussionReport);
        if(!isOk) {
            throw new StatusFailException("修改失败");
        }
    }
}
