package com.github.loj.dao.discussion.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.dao.discussion.ReplyEntityService;
import com.github.loj.dao.msg.MsgRemindEntityService;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.mapper.ReplyMapper;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.discussion.Reply;
import com.github.loj.pojo.entity.msg.MsgRemind;
import com.github.loj.pojo.vo.ReplyVO;
import com.github.loj.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyEntityServiceImpl extends ServiceImpl<ReplyMapper, Reply> implements ReplyEntityService {

    @Autowired
    private DiscussionEntityService discussionEntityService;

    @Autowired
    private MsgRemindEntityService msgRemindEntityService;

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private UserInfoEntityService userInfoEntityService;

    @Autowired
    private ReplyMapper replyMapper;

    @Override
    public void updateReplyMsg(Integer sourceId, String sourceType, String content,
                               Integer quoteId, String quoteType, String recipientId, String senderId) {
        if(content.length() > 200) {
            content= content.substring(0, 200) + "...";
        }
        MsgRemind msgRemind = new MsgRemind();
        msgRemind.setAction("Reply")
                .setSourceId(sourceId)
                .setSourceType(sourceType)
                .setSourceContent(content)
                .setQuoteId(quoteId)
                .setQuoteType(quoteType)
                .setRecipientId(recipientId)
                .setSenderId(senderId);

        if(sourceType.equals("Discussion")) {
            Discussion discussion = discussionEntityService.getById(sourceId);
            if(discussion != null) {
                if (discussion.getGid() != null) {
                    msgRemind.setUrl("/group/" + discussion.getGid() + "/discussion-detail/" + sourceId);
                } else {
                    msgRemind.setUrl("/discussion-detail/" + sourceId);
                }
            }
        } else if(sourceType.equals("Contest")) {
            msgRemind.setUrl("/contest/" + sourceId + "/comment");
        }

        msgRemindEntityService.saveOrUpdate(msgRemind);
    }

    @Override
    public List<ReplyVO> getAllReplyByCommentId(Long cid, String uid, Boolean isRoot, Integer commentId) {
        if(cid != null) {
            Contest contest = contestEntityService.getById(cid);
            boolean onlyMineAndAdmin = contest.getStatus().equals(Constants.Contest.STATUS_RUNNING.getCode())
                    && !isRoot && !contest.getUid().equals(uid);
            if(onlyMineAndAdmin) {
                List<String> myAndAdminUidList = userInfoEntityService.getSuperAdminUidList();
                myAndAdminUidList.add(uid);
                myAndAdminUidList.add(contest.getUid());
                return replyMapper.getAllReplyByCommentId(commentId, myAndAdminUidList);
            }
        }
        return replyMapper.getAllReplyByCommentId(commentId, null);
    }
}
