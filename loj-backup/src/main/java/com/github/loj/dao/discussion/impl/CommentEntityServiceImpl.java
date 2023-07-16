package com.github.loj.dao.discussion.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.discussion.CommentEntityService;
import com.github.loj.dao.group.GroupMemberEntityService;
import com.github.loj.dao.msg.MsgRemindEntityService;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.mapper.CommentMapper;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.discussion.Comment;
import com.github.loj.pojo.entity.group.GroupMember;
import com.github.loj.pojo.entity.msg.MsgRemind;
import com.github.loj.pojo.vo.CommentVO;
import com.github.loj.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/25 1:09
 */
@Service
public class CommentEntityServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentEntityService {

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private UserInfoEntityService userInfoEntityService;

    @Autowired
    private GroupMemberEntityService groupMemberEntityService;

    @Autowired
    private CommentMapper commentMapper;

    @Resource
    private MsgRemindEntityService msgRemindEntityService;

    @Override
    public IPage<CommentVO> getCommentList(int limit, int currentPage, Long cid, Integer did, Boolean isRoot, String uid) {

        Page<CommentVO> page = new Page<>(currentPage, limit);

        if(cid != null) {
            Contest contest = contestEntityService.getById(cid);

            boolean onlyMineAndAdmin = contest.getStatus().equals(Constants.Contest.STATUS_RUNNING.getCode())
                    && !isRoot && !contest.getUid().equals(uid);
            if(onlyMineAndAdmin) { // 自己和比赛管理者评论可看

                List<String> myAndAdminUidList = userInfoEntityService.getSuperAdminUidList();
                myAndAdminUidList.add(uid);
                myAndAdminUidList.add(contest.getUid());
                Long gid = contest.getGid();
                if(gid!=null) {
                    QueryWrapper<GroupMember> groupMemberQueryWrapper = new QueryWrapper<>();
                    groupMemberQueryWrapper.eq("gid", gid).eq("auth", 5);
                    List<GroupMember> groupAdminUidList = groupMemberEntityService.list(groupMemberQueryWrapper);

                    for(GroupMember groupMember: groupAdminUidList) {
                        myAndAdminUidList.add(groupMember.getUid());
                    }
                }

                return commentMapper.getCommentList(page, cid, did, true, myAndAdminUidList);
            }

        }
        return commentMapper.getCommentList(page, cid, did, false, null);
    }

    @Async
    @Override
    public void updateCommentMsg(String recipientId, String senderId, String content, Integer discussionId, Long gid) {
        if(content.length() > 200) {
            content = content.substring(0, 200) + "...";
        }
        MsgRemind msgRemind = new MsgRemind();
        msgRemind.setAction("Discuss")
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
