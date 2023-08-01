package com.github.loj.manager.msg;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.discussion.CommentEntityService;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.dao.discussion.ReplyEntityService;
import com.github.loj.dao.msg.MsgRemindEntityService;
import com.github.loj.dao.msg.UserSysNoticeEntityService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.discussion.Comment;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.discussion.Reply;
import com.github.loj.pojo.entity.msg.MsgRemind;
import com.github.loj.pojo.entity.msg.UserSysNotice;
import com.github.loj.pojo.vo.UserMsgVO;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;
import com.github.loj.shiro.AccountProfile;
import org.apache.shiro.SecurityUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/14 20:58
 */
@Component
public class UserMessageManager {

    @Resource
    private MsgRemindEntityService msgRemindEntityService;

    @Resource
    private UserSysNoticeEntityService userSysNoticeEntityService;

    @Resource
    private DiscussionEntityService discussionEntityService;

    @Resource
    private ApplicationContext applicationContext;

    @Resource
    private ContestEntityService contestEntityService;

    @Resource
    private CommentEntityService commentEntityService;

    @Resource
    private ReplyEntityService replyEntityService;

    public UserUnreadMsgCountVO getUnreadMsgCount() {
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        UserUnreadMsgCountVO userUnreadMsgCount = msgRemindEntityService.getUserUnreadMsgCount(userRolesVo.getUid());
        if(userUnreadMsgCount == null) {
            userUnreadMsgCount = new UserUnreadMsgCountVO(0, 0, 0, 0, 0);
        }
        return userUnreadMsgCount;
    }

    public void cleanMsg(String type, Long id) throws StatusFailException {

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isOk = cleanMsgByType(type, id, userRolesVo.getUid());
        if(!isOk) {
            throw new StatusFailException("清空失败");
        }
    }


    private boolean cleanMsgByType(String type, Long id, String uid) {

        switch (type) {
            case "Like":
            case "Discuss":
            case "Reply":
                UpdateWrapper<MsgRemind> updateWrapper1 = new UpdateWrapper<>();
                updateWrapper1
                        .eq(id != null, "id", id)
                        .eq("recipient_id", uid);
                return msgRemindEntityService.remove(updateWrapper1);
            case "Sys":
            case "Mine":
                UpdateWrapper<UserSysNotice> updateWrapper2 = new UpdateWrapper<>();
                updateWrapper2
                        .eq(id != null, "id", id)
                        .eq("recipient_id", uid);
                return userSysNoticeEntityService.remove(updateWrapper2);
        }
        return false;
    }

    public IPage<UserMsgVO> getCommentMsg(Integer limit, Integer currentPage) {

        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 5;
        }
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        return getUserMsgList(userRolesVo.getUid(),"Discuss", limit, currentPage);
    }

    private IPage<UserMsgVO> getUserMsgList(String uid, String action, int limit, int currentPage) {
        Page<UserMsgVO> page = new Page<>(currentPage, limit);
        IPage<UserMsgVO> userMsgList = msgRemindEntityService.getUserMsg(page, uid, action);
        if(userMsgList.getTotal() > 0) {
            switch (action) {
                case "Discuss":
                    // 评论我的
                    return getUserDiscussMsgList(userMsgList);
                case "Reply":
                    // 回复我的
                    return getUserReplyMsgList(userMsgList);
                case "Like":
                    return getUserLikeMsgList(userMsgList);
                default:
                    throw new RuntimeException("invalid action:" + action);
            }
        } else {
            return userMsgList;
        }
    }

    private IPage<UserMsgVO> getUserLikeMsgList(IPage<UserMsgVO> userMsgList) {
        for(UserMsgVO userMsgVO: userMsgList.getRecords()) {
            if("Discussion".equals(userMsgVO.getSourceType())) {
                Discussion discussion = discussionEntityService.getById(userMsgVO.getSourceId());
                if(discussion != null) {
                    userMsgVO.setSourceTitle(discussion.getTitle());
                } else {
                    userMsgVO.setSourceTitle("原讨论帖已被删除!【The original discussion post has been deleted!】");
                }
            } else if("Contest".equals(userMsgVO.getSourceType())) {
                Contest contest = contestEntityService.getById(userMsgVO.getSourceId());
                if(contest != null) {
                    userMsgVO.setSourceTitle(contest.getTitle());
                } else {
                    userMsgVO.setSourceTitle("原比赛已被删除!【The original contest has been deleted!】");
                }
            }
        }
        applicationContext.getBean(UserMessageManager.class).updateUserMsgRead(userMsgList);
        return userMsgList;
    }

    private IPage<UserMsgVO> getUserReplyMsgList(IPage<UserMsgVO> userMsgList) {
        for(UserMsgVO userMsgVO: userMsgList.getRecords()) {

            if("Disucssion".equals(userMsgVO.getSourceTitle())) {
                Discussion discussion = discussionEntityService.getById(userMsgVO.getSourceId());
                if(discussion != null) {
                    userMsgVO.setSourceTitle(discussion.getTitle());
                } else {
                    userMsgVO.setSourceTitle("原讨论帖已被删除!【The original discussion post has been deleted!】");
                }
            } else if("Contest".equals(userMsgVO.getSourceType())) {
                Contest contest = contestEntityService.getById(userMsgVO.getSourceId());
                if(contest != null) {
                    userMsgVO.setSourceTitle(contest.getTitle());
                } else {
                    userMsgVO.setSourceTitle("原比赛已被删除!【The original contest has been deleted!】");
                }
            }

            if("Comment".equals(userMsgVO.getQuoteType())) {
                Comment comment = commentEntityService.getById(userMsgVO.getQuoteId());
                if(comment != null) {
                    String content;
                    if(comment.getContent().length() < 100) {
                        content = comment.getFromName() + " : "
                                + comment.getContent();
                    } else {
                        content = comment.getFromName() + " : "
                                + comment.getContent().substring(0, 100) + "...";
                    }
                    userMsgVO.setQuoteContent(content);
                } else {
                    userMsgVO.setQuoteContent("您的原评论信息已被删除！【Your original comments have been deleted!】");
                }
            } else if("Reply".equals(userMsgVO.getQuoteType())) {
                Reply reply = replyEntityService.getById(userMsgVO.getQuoteId());
                if(reply != null) {
                    String content;
                    if(reply.getContent().length() < 100) {
                        content = reply.getFromName()  + " : @" + reply.getToName() + "："
                                + reply.getContent();
                    } else {
                        content = reply.getFromName()  + " : @" + reply.getToName() + "："
                                + reply.getContent().substring(0, 100) + "...";
                    }
                    userMsgVO.setQuoteContent(content);
                } else {
                    userMsgVO.setQuoteContent("您的原回复信息已被删除！【Your original reply has been deleted!】");
                }
            }
        }

        applicationContext.getBean(UserMessageManager.class).updateUserMsgRead(userMsgList);
        return userMsgList;
    }

    private IPage<UserMsgVO> getUserDiscussMsgList(IPage<UserMsgVO> userMsgList) {

        List<Integer> discussionIds = userMsgList.getRecords()
                .stream()
                .map(UserMsgVO::getSourceId)
                .collect(Collectors.toList());
        Collection<Discussion> discussions = discussionEntityService.listByIds(discussionIds);
        for(Discussion discussion: discussions) {
            for(UserMsgVO userMsgVO: userMsgList.getRecords()) {
                if(Objects.equals(discussion.getId(), userMsgVO.getSourceId())) {
                    userMsgVO.setSourceTitle(discussion.getTitle());
                    break;
                }
            }
        }
        applicationContext.getBean(UserMessageManager.class).updateUserMsgRead(userMsgList);
        return userMsgList;
    }


    @Async
    public void updateUserMsgRead(IPage<UserMsgVO> userMsgList) {
        List<Long> idList = userMsgList.getRecords().stream()
                .filter(userMsgVO ->  !userMsgVO.getState())
                .map(UserMsgVO::getId)
                .collect(Collectors.toList());

        if(idList.size() == 0) {
            return;
        }
        UpdateWrapper<MsgRemind> updateWrapper = new UpdateWrapper<>();
        updateWrapper.in("id", idList)
                .set("state", true);
        msgRemindEntityService.update(null, updateWrapper);
    }

}
