package com.github.loj.manager.oj;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.LOJAccessEnum;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.discussion.CommentEntityService;
import com.github.loj.pojo.entity.discussion.CommentLike;
import com.github.loj.dao.discussion.CommentLikeEntityService;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.vo.CommentListVO;
import com.github.loj.pojo.vo.CommentVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.AccessValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.rmi.AccessException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:27
 */
@Component
public class CommentManager {

    @Autowired
    private DiscussionEntityService discussionEntityService;

    @Autowired
    private CommentLikeEntityService commentLikeEntityService;

    @Autowired
    private AccessValidator accessValidator;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private CommentEntityService commentEntityService;

    public CommentListVO getComments(Long cid, Integer did, Integer limit, Integer currentPage) throws AccessException, StatusForbiddenException {

        // 如果有登录，则获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        if(cid == null && did != null) {
            QueryWrapper<Discussion> discussionQueryWrapper = new QueryWrapper<>();
            Discussion discussion = discussionEntityService.getOne(discussionQueryWrapper);
            if(discussion != null && discussion.getGid() != null) {
                accessValidator.validateAccess(LOJAccessEnum.GROUP_DISCUSSION);
                if(!isRoot && ! groupValidator.isGroupMember(userRolesVo.getUid(), discussion.getGid())) {
                    throw new StatusForbiddenException("对不起，您无权限操作！");
                }
            } else {
                accessValidator.validateAccess(LOJAccessEnum.PUBLIC_DISCUSSION);
            }
        } else {
            accessValidator.validateAccess(LOJAccessEnum.CONTEST_COMMENT);
        }

        IPage<CommentVO> commentList = commentEntityService.getCommentList(limit, currentPage, cid, did, isRoot,
                userRolesVo != null ? userRolesVo.getUid(): null);

        HashMap<Integer, Boolean> commentLikeMap = new HashMap<>();

        if(userRolesVo != null) {
            // 如果是有登录 需要检查是否对评论有点赞
            List<Integer> commentIdList = new LinkedList<>();
            for(CommentVO commentVO: commentList.getRecords()) {
                commentIdList.add(commentVO.getId());
            }

            if(commentIdList.size() > 0) {
                QueryWrapper<CommentLike> commentLikeQueryWrapper = new QueryWrapper<>();
                commentLikeQueryWrapper.in("cid", commentIdList);

                List<CommentLike> commentLikeList = commentLikeEntityService.list(commentLikeQueryWrapper);

                // 如果存在记录需要修正Map为true
                for(CommentLike tmp : commentLikeList) {
                    commentLikeMap.put(tmp.getCid(), true);
                }
            }

        }
        CommentListVO commentListVO = new CommentListVO();
        commentListVO.setCommentList(commentList);
        commentListVO.setCommentLikeMap(commentLikeMap);
        return commentListVO;
    }

}
