package com.github.loj.manager.group.discussion;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@Component
public class GroupDiscussionManager {

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private DiscussionEntityService discussionEntityService;

    public IPage<Discussion> getDiscussionList(Integer limit, Integer currentPage, Long gid, String pid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取讨论列表失败，该团队不存在或已被封禁！");
        }

        if(!groupValidator.isGroupMember(userRolesVo.getUid(), gid) && !isRoot) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        QueryWrapper<Discussion> discussionQueryWrapper = new QueryWrapper<>();

        if(!StringUtils.isEmpty(pid)) {
            discussionQueryWrapper.eq("pid", pid);
        }
        IPage<Discussion> iPage = new Page<>(currentPage, limit);

        discussionQueryWrapper
                .eq("status", 0)
                .eq("gid",gid)
                .orderByDesc("top_priority")
                .orderByDesc("gmt_create")
                .orderByDesc("like_num")
                .orderByDesc("view_num");
        return discussionEntityService.page(iPage, discussionQueryWrapper);
    }
}
