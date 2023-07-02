package com.github.loj.manager.oj;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.annotation.LOJAccessEnum;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.dao.problem.CategoryEntityService;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.problem.Category;
import com.github.loj.pojo.vo.DiscussionVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.AccessValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.rmi.AccessException;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/27 23:48
 */
@Component
public class DiscussionManager {

    @Autowired
    private CategoryEntityService categoryEntityService;

    @Autowired
    private DiscussionEntityService discussionEntityService;

    @Autowired
    private AccessValidator accessValidator;

    @Autowired
    private GroupValidator groupValidator;

    public List<Category> getDiscussionCategory() {
        return categoryEntityService.list();
    }

    public IPage<Discussion> getDiscussionList(Integer limit,
                                               Integer currentPage,
                                               Integer categoryId,
                                               String pid,
                                               boolean onlyMine,
                                               String keyword,
                                               boolean admin) {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        QueryWrapper<Discussion> discussionQueryWrapper = new QueryWrapper<>();

        IPage<Discussion> iPage = new Page<>(currentPage, limit);

        if(categoryId != null) {
            discussionQueryWrapper.eq("category_id", categoryId);
        }

        if(!StringUtils.isEmpty(keyword)) {
            final String key = keyword.trim();

            discussionQueryWrapper.and(wrapper -> wrapper.like("title",key).or()
                    .like("author",key).or()
                    .like("id", key).or()
                    .like("description",key));
        }

        boolean isAdmin = SecurityUtils.getSubject().hasRole("root")
                || SecurityUtils.getSubject().hasRole("problem_admin")
                || SecurityUtils.getSubject().hasRole("admin");

        if(!StringUtils.isEmpty(pid)) {
            discussionQueryWrapper.eq("pid", pid);
        }

        if(!(admin && isAdmin)) {
            discussionQueryWrapper.isNull("gid");
        }

        discussionQueryWrapper
                .eq(!(admin && isAdmin), "status", 0)
                .orderByDesc("top_priority")
                .orderByDesc("gmt_create")
                .orderByDesc("like_num")
                .orderByDesc("view_num");

        if(onlyMine && userRolesVo != null) {
            discussionQueryWrapper.eq("uid", userRolesVo.getUid());
        }

        IPage<Discussion> discussionIPage = discussionEntityService.page(iPage, discussionQueryWrapper);
        List<Discussion> records = discussionIPage.getRecords();
        if(!CollectionUtils.isEmpty(records)) {
            for(Discussion discussion: records) {
                if(userRolesVo == null) {
                    discussion.setContent(null);
                } else if(!userRolesVo.getUid().equals(discussion.getUid())) {
                    discussion.setContent(null);
                }
            }
        }
        return discussionIPage;
    }

    public DiscussionVO getDiscussion(Integer did) throws StatusNotFoundException, StatusForbiddenException, AccessException {

        // 获取当前用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        String uid = null;

        if(userRolesVo != null) {
            uid = userRolesVo.getUid();
        }

        DiscussionVO discussionVO = discussionEntityService.getDiscussion(did, uid);

        if(discussionVO == null) {
            throw new StatusNotFoundException("对不起，该讨论不存在！");
        }

        if(discussionVO.getGid() != null && uid == null) {
            throw new StatusNotFoundException("对不起，请先登录后再访问团队讨论！");
        }

        if(discussionVO.getStatus() == 1) {
            throw new StatusForbiddenException("对不起，该讨论已被封禁！");
        }

        if(discussionVO.getGid() != null) {
            accessValidator.validateAccess(LOJAccessEnum.GROUP_DISCUSSION);
            if(!isRoot && !discussionVO.getUid().equals(uid)
                    && !groupValidator.isGroupMember(uid, discussionVO.getGid())) {
                throw new StatusForbiddenException("对不起，您无权限操作！");
            }
        } else {
            accessValidator.validateAccess(LOJAccessEnum.PUBLIC_DISCUSSION);
        }

        UpdateWrapper<Discussion> discussionUpdateWrapper = new UpdateWrapper<>();
        discussionUpdateWrapper.setSql("view_num=view_num+1").eq("id", discussionVO.getId());
        discussionEntityService.update(discussionUpdateWrapper);
        discussionVO.setViewNum(discussionVO.getViewNum() + 1);

        return discussionVO;
    }
}
