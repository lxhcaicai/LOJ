package com.github.loj.manager.oj;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.extra.emoji.EmojiUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.LOJAccessEnum;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.config.NacosSwitchConfig;
import com.github.loj.config.SwitchConfig;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.discussion.CommentEntityService;
import com.github.loj.dao.discussion.ReplyEntityService;
import com.github.loj.dao.user.UserAcproblemEntityService;
import com.github.loj.pojo.dto.ReplyDTO;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.discussion.Comment;
import com.github.loj.pojo.entity.discussion.CommentLike;
import com.github.loj.dao.discussion.CommentLikeEntityService;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.discussion.Reply;
import com.github.loj.pojo.entity.user.UserAcproblem;
import com.github.loj.pojo.vo.CommentListVO;
import com.github.loj.pojo.vo.CommentVO;
import com.github.loj.pojo.vo.ReplyVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.AccessValidator;
import com.github.loj.validator.CommonValidator;
import com.github.loj.validator.ContestValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.rmi.AccessException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

    @Autowired
    private CommonValidator commonValidator;

    @Autowired
    private UserAcproblemEntityService userAcproblemEntityService;

    @Autowired
    private ReplyEntityService replyEntityService;

    @Autowired
    private NacosSwitchConfig nacosSwitchConfig;

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private ContestValidator contestValidator;

    private final static Pattern pattern = Pattern.compile("<.*?([a,A][u,U][t,T][o,O][p,P][l,L][a,A][y,Y]).*?>");

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

    @Transactional
    public CommentVO addComment(Comment comment) throws StatusFailException, AccessException, StatusForbiddenException {

        commonValidator.validateContent(comment.getContent(),"评论", 10000);

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
        boolean isAdmin = SecurityUtils.getSubject().hasRole("admin");

        Long cid = comment.getCid();
        // 比赛外的评论 除管理员外 只有AC 10道以上才可评论
        if(cid == null) {

            QueryWrapper<Discussion> discussionQueryWrapper = new QueryWrapper<>();
            discussionQueryWrapper.select("id","gid").eq("id", comment.getDid());
            Discussion discussion = discussionEntityService.getOne(discussionQueryWrapper);

            if(discussion == null) {
                throw new StatusFailException("评论失败，该讨论已不存在！");
            }
            Long gid = discussion.getGid();
            if(gid != null) {
                accessValidator.validateAccess(LOJAccessEnum.GROUP_DISCUSSION);
                if(!isRoot && !groupValidator.isGroupMember(userRolesVo.getUid(), gid)) {
                    throw new StatusForbiddenException("对不起，您无权限操作！");
                }
            } else {
                accessValidator.validateAccess(LOJAccessEnum.PUBLIC_DISCUSSION);
            }

            if(!isRoot && !isProblemAdmin && !isAdmin) {
                QueryWrapper<UserAcproblem> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("uid", userRolesVo.getUid()).select("distinct pid");
                int userAcProblemCount = userAcproblemEntityService.count(queryWrapper);

                SwitchConfig switchConfig = nacosSwitchConfig.getSwitchConfig();
                if(userAcProblemCount < switchConfig.getDefaultCreateDiscussionACInitValue()) {
                    throw new StatusForbiddenException("对不起，您暂时不能评论！请先去提交题目通过"
                            + switchConfig.getDefaultCreateCommentACInitValue() + "道以上!");
                }
            }
        } else {
            accessValidator.validateAccess(LOJAccessEnum.CONTEST_COMMENT);
            Contest contest = contestEntityService.getById(cid);
            if(contest == null) {
                throw new StatusFailException("评论失败，该比赛已不存在！");
            }
            contestValidator.validateContestAuth(contest,userRolesVo,isRoot);
        }

        comment.setFromAvatar(userRolesVo.getAvatar())
                .setFromName(userRolesVo.getUsername())
                .setFromUid(userRolesVo.getUid());

        if(SecurityUtils.getSubject().hasRole("root")) {
            comment.setFromRole("root");
        } else if(SecurityUtils.getSubject().hasRole("admin")
                || SecurityUtils.getSubject().hasRole("problem_admin")) {
            comment.setFromRole("admin");
        } else {
            comment.setFromRole("user");
        }

        // 带有表情的字符串转换为编码
        comment.setContent(EmojiUtil.toHtml(formatContentRemoveAutoPlay(comment.getContent())));

        boolean isOk = commentEntityService.saveOrUpdate(comment);

        if(isOk) {
            CommentVO commentVO = new CommentVO();
            commentVO.setContent(comment.getContent());
            commentVO.setId(comment.getId());
            commentVO.setFromAvatar(comment.getFromAvatar());
            commentVO.setFromName(comment.getFromName());
            commentVO.setFromUid(comment.getFromUid());
            commentVO.setLikeNum(0);
            commentVO.setGmtCreate(comment.getGmtCreate());
            commentVO.setReplyList(new LinkedList<>());
            commentVO.setFromTitleName(userRolesVo.getTitleName());
            commentVO.setFromTitleColor(userRolesVo.getTitleColor());
            // 如果是讨论区的回复，发布成功需要添加统计该讨论的回复数
            if(comment.getDid() != null) {
                Discussion discussion = discussionEntityService.getById(comment.getDid());
                if(discussion != null) {
                    discussion.setCommentNum(discussion.getCommentNum() + 1);
                    discussionEntityService.updateById(discussion);
                    // 更新消息
                    commentEntityService.updateCommentMsg(discussion.getUid(),
                            userRolesVo.getUid(),
                            comment.getContent(),
                            comment.getDid(),
                            discussion.getGid());
                }
            }
            return commentVO;
        } else {
            throw new StatusFailException("评论失败，请重新尝试！");
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public void addCommentLike(Integer cid, Boolean toLike, Integer sourceId, String sourceType) throws StatusFailException {

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        QueryWrapper<CommentLike> commentLikeQueryWrapper = new QueryWrapper<>();
        commentLikeQueryWrapper.eq("cid", cid).eq("uid",userRolesVo.getUid());

        CommentLike commentLike = commentLikeEntityService.getOne(commentLikeQueryWrapper,false);

        if(toLike) { // 添加点赞
            if(commentLike == null) {
                boolean isSave = commentLikeEntityService.saveOrUpdate(new CommentLike()
                        .setUid(userRolesVo.getUid())
                        .setCid(cid));
                if(!isSave) {
                    throw new StatusFailException("点赞失败，请重试尝试！");
                }
            }
            // 点赞+1
            Comment comment = commentEntityService.getById(cid);
            if(comment != null) {
                comment.setLikeNum(comment.getLikeNum() + 1);
                commentEntityService.updateById(comment);
                // 当前的评论要不是点赞者的 才发送点赞消息
                if(!userRolesVo.getUsername().equals(comment.getFromName())) {
                    commentEntityService.updateCommentLikeMsg(comment.getFromUid(), userRolesVo.getUid(),sourceId, sourceType);
                }
            }
        } else { // 取消点赞
            if(commentLike != null) {
                boolean isDelete = commentLikeEntityService.removeById(commentLike.getId());
                if(!isDelete) {
                    throw new StatusFailException("取消点赞失败，请重试尝试！");
                }
            }

            // 点赞 - 1
            UpdateWrapper<Comment> commentUpdateWrapper = new UpdateWrapper<>();
            commentUpdateWrapper.setSql("like_num=like_num-1").eq("id", cid);
            commentEntityService.update(commentUpdateWrapper);
        }

    }

    private String formatContentRemoveAutoPlay(String content) {
        StringBuilder sb = new StringBuilder(content);
        Matcher matcher = pattern.matcher(content);
        while (matcher.find()) {
            sb.replace(matcher.start(1), matcher.end(1), "controls");
        }
        return sb.toString();
    }

    @Transactional(rollbackFor = Exception.class)
    public void deleteComment(Comment comment) throws StatusFailException, StatusForbiddenException, AccessException {
        commonValidator.validateNotEmpty(comment.getId(), "评论ID");
        // 如果不是评论本人 或者不是管理员 无权限删除该评论
        comment = commentEntityService.getById(comment.getId());
        if(comment == null) {
            throw new StatusFailException("删除失败，当前评论已不存在！");
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
        boolean isAdmin = SecurityUtils.getSubject().hasRole("admin");

        Long cid = comment.getCid();
        if(cid == null) {
            QueryWrapper<Discussion> discussionQueryWrapper = new QueryWrapper<>();
            discussionQueryWrapper.select("id","gid").eq("id", comment.getDid());
            Discussion discussion = discussionEntityService.getOne(discussionQueryWrapper);
            Long gid = discussion.getGid();
            if(gid == null) {
                accessValidator.validateAccess(LOJAccessEnum.PUBLIC_DISCUSSION);
                if(!comment.getFromUid().equals(userRolesVo.getUid()) && !isRoot && !isProblemAdmin && !isAdmin) {
                    throw new StatusForbiddenException("无权删除该评论");
                }
            } else {
                accessValidator.validateAccess(LOJAccessEnum.GROUP_DISCUSSION);
                if(!groupValidator.isGroupAdmin(userRolesVo.getUid(), gid)
                        && !comment.getFromUid().equals(userRolesVo.getUid())
                        && !isRoot) {
                    throw new StatusForbiddenException("无权删除该评论");
                }
            }
        } else {
            accessValidator.validateAccess(LOJAccessEnum.CONTEST_COMMENT);
            Contest contest = contestEntityService.getById(cid);
            Long gid = contest.getGid();
            if(!comment.getFromUid().equals(userRolesVo.getUid())
                    && !isRoot
                    && !contest.getUid().equals(userRolesVo.getUid())
                    && !(contest.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), gid))) {
                throw new StatusForbiddenException("无权删除该评论");
            }
        }
        // 获取需要删除该评论的回复数
        int replyNum = replyEntityService.count(new QueryWrapper<Reply>().eq("comment_id",comment.getId()));

        // 删除该数据 包括关联外键的reply表数据
        boolean isDeleteComment = commentEntityService.removeById(comment.getId());

        // 同时需要删除该评论的回复表数据
        replyEntityService.remove(new UpdateWrapper<Reply>().eq("comment_id", comment.getId()));
        if(isDeleteComment) {
            // 如果是讨论区的回复，删除成功需要减少统计该讨论的回复数
            if(comment.getDid() != null) {
                UpdateWrapper<Discussion> discussionUpdateWrapper = new UpdateWrapper<>();
                discussionUpdateWrapper.eq("id", comment.getDid())
                        .setSql("comment_num=comment_num-" + (replyNum + 1));
                discussionEntityService.update(discussionUpdateWrapper);
            }
        } else {
            throw new StatusFailException("删除失败，请重新尝试");
        }
    }

    public ReplyVO addReply(ReplyDTO replyDTO) throws StatusFailException, AccessException, StatusForbiddenException {

        commonValidator.validateContent(replyDTO.getReply().getContent(),"回复", 10000);

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
        boolean isAdmin = SecurityUtils.getSubject().hasRole("admin");

        Reply reply = replyDTO.getReply();
        if(reply == null || reply.getCommentId() == null) {
            throw new StatusFailException("回复失败，当前请求的参数错误！");
        }

        Comment comment = commentEntityService.getById(reply.getCommentId());

        if(comment == null) {
            throw new StatusFailException("回复失败，当前评论已不存在！");
        }

        Long cid = comment.getCid();
        if(cid == null) {
            QueryWrapper<Discussion> discussionQueryWrapper = new QueryWrapper<>();
            discussionQueryWrapper.select("id","gid").eq("id",comment.getDid());
            Discussion discussion = discussionEntityService.getOne(discussionQueryWrapper);

            Long gid = discussion.getGid();
            if(gid != null) {
                accessValidator.validateAccess(LOJAccessEnum.GROUP_DISCUSSION);
                if(!groupValidator.isGroupMember(userRolesVo.getUid(),gid) && isRoot) {
                    throw new StatusForbiddenException("对不起，您无权限回复！");
                }
            } else {
                accessValidator.validateAccess(LOJAccessEnum.PUBLIC_DISCUSSION);
            }

            if(!isRoot && !isProblemAdmin && !isAdmin) {
                QueryWrapper<UserAcproblem> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("uid", userRolesVo.getUid()).select("distinct pid");
                int userAcProblemCount = userAcproblemEntityService.count(queryWrapper);
                SwitchConfig switchConfig = nacosSwitchConfig.getSwitchConfig();
                if(userAcProblemCount < switchConfig.getDefaultCreateCommentACInitValue()) {
                    throw new StatusForbiddenException("对不起，您暂时不能回复！请先去提交题目通过" +
                            switchConfig.getDefaultCreateCommentACInitValue() + "道以上!");
                }
            }

        } else {
            accessValidator.validateAccess(LOJAccessEnum.CONTEST_COMMENT);
            Contest contest = contestEntityService.getById(cid);
            Long gid = contest.getGid();
            if(!comment.getFromUid().equals(userRolesVo.getUid())
                    && !isRoot
                    && !contest.getUid().equals(userRolesVo.getUid())
                    && !(contest.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), gid))) {
                throw new StatusForbiddenException("对不起，您无权限回复！");
            }
        }
        reply.setFromAvatar(userRolesVo.getAvatar())
                .setFromName(userRolesVo.getUsername())
                .setFromUid(userRolesVo.getUid());
        if(SecurityUtils.getSubject().hasRole("root")) {
            reply.setFromRole("root");
        } else if(SecurityUtils.getSubject().hasRole("admin")
                || SecurityUtils.getSubject().hasRole("problem_admin")) {
            reply.setFromRole("admin");
        } else {
            reply.setFromRole("user");
        }
        // 带有表情的字符串转换为编码
        reply.setContent(EmojiUtil.toHtml(formatContentRemoveAutoPlay(reply.getContent())));

        boolean isOk = replyEntityService.saveOrUpdate(reply);

        if(isOk) {
            // 如果是讨论区的回复，发布成功需要增加统计该讨论的回复数
            if(replyDTO.getDid() != null) {
                UpdateWrapper<Discussion> discussionUpdateWrapper = new UpdateWrapper<>();
                discussionUpdateWrapper.eq("id", replyDTO.getDid())
                        .setSql("comment_num=comment_num+1");
                discussionEntityService.update(discussionUpdateWrapper);
                // 更新消息
                replyEntityService.updateReplyMsg(replyDTO.getDid(),
                        "Discussion",
                        reply.getContent(),
                        replyDTO.getQuoteId(),
                        replyDTO.getQuoteType(),
                        reply.getToUid(),
                        reply.getFromUid());
            }

            ReplyVO replyVO = new ReplyVO();
            BeanUtil.copyProperties(reply,replyVO);
            replyVO.setFromTitleName(userRolesVo.getTitleName());
            replyVO.setFromTitleColor(userRolesVo.getTitleColor());
            return replyVO;
        }  else {
            throw new StatusFailException("回复失败，请重新尝试！");
        }

    }

}
