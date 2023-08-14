package com.github.loj.manager.group.discussion;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.user.UserAcproblemEntityService;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.user.UserAcproblem;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.utils.RedisUtils;
import com.github.loj.validator.CommonValidator;
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

    @Autowired
    private CommonValidator commonValidator;

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private UserAcproblemEntityService userAcproblemEntityService;

    @Autowired
    private RedisUtils redisUtils;

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

    public IPage<Discussion> getAdminDiscussionList(Integer limit, Integer currentPage, Long gid) throws StatusNotFoundException, StatusForbiddenException {
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

        IPage<Discussion> iPage = new Page<>(currentPage, limit);

        discussionQueryWrapper
                .eq("gid",gid)
                .orderByDesc("top_priority")
                .orderByDesc("gmt_create")
                .orderByDesc("like_num")
                .orderByDesc("view_num");
        return discussionEntityService.page(iPage, discussionQueryWrapper);
    }

    public void addDiscussion(Discussion discussion) throws StatusFailException, StatusNotFoundException, StatusForbiddenException {
        commonValidator.validateContent(discussion.getTitle(), "讨论标题", 255);
        commonValidator.validateContent(discussion.getDescription(), "讨论描述", 255);
        commonValidator.validateContent(discussion.getContent(), "讨论", 65535);
        commonValidator.validateNotEmpty(discussion.getCategoryId(), "讨论分类");
        commonValidator.validateNotEmpty(discussion.getGid(), "讨论所属团队ID");

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
        boolean isAdmin = SecurityUtils.getSubject().hasRole("admin");

        Long gid = discussion.getGid();
        Group group = groupEntityService.getById(gid);
        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("添加失败，该团队不存在或已被封禁！");
        }

        if(!groupValidator.isGroupMember(userRolesVo.getUid(), gid) && !isRoot) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        String problemId = discussion.getPid();
        if(problemId != null) {
            QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
            problemQueryWrapper.eq("problem_id", problemId);
            Problem problem = problemEntityService.getOne(problemQueryWrapper);

            if(problem == null) {
                throw new StatusNotFoundException("该题目不存在");
            } else if(problem.getIsGroup()) {
                discussion.setGid(problem.getGid());
            }
        }

        if(!isAdmin && !isRoot && !isProblemAdmin) {
            QueryWrapper<UserAcproblem> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("uid",  userRolesVo.getUid()).select("distinct pid");
            int userAcproblemCount = userAcproblemEntityService.count(queryWrapper);

            if(userAcproblemCount < 10) {
                throw new StatusForbiddenException("对不起，您暂时不能评论！请先去提交题目通过10道以上!");
            }

            String lockKey = Constants.Account.DISCUSSION_ADD_NUM_LOCK.getCode() + userRolesVo.getUid();
            Integer num = (Integer) redisUtils.get(lockKey);
            if(num == null) {
                redisUtils.set(lockKey, 1, 3600 * 24);
            } else if (num >= 5) {
                throw new StatusForbiddenException("对不起，您今天发帖次数已超过5次，已被限制！");
            } else {
                redisUtils.incr(lockKey,1);
            }
        }


        discussion.setAuthor(userRolesVo.getUsername())
                .setAvatar(userRolesVo.getAvatar())
                .setUid(userRolesVo.getUid());

        if(groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            discussion.setRole("root");
        } else if(groupValidator.isGroupAdmin(userRolesVo.getUid(), gid)) {
            discussion.setRole("admin");
        } else {
            discussion.setTopPriority(false);
        }

        boolean isOk = discussionEntityService.save(discussion);
        if(!isOk) {
            throw new StatusFailException("添加失败");
        }

    }

    public void updateDiscussion(Discussion discussion) throws StatusFailException, StatusNotFoundException, StatusForbiddenException {

        commonValidator.validateNotEmpty(discussion.getId(), "讨论ID");
        commonValidator.validateContent(discussion.getTitle(), "讨论标题", 255);
        commonValidator.validateContent(discussion.getDescription(), "讨论描述", 255);
        commonValidator.validateContent(discussion.getContent(), "讨论", 65535);
        commonValidator.validateNotEmpty(discussion.getCategoryId(), "讨论分类");

        QueryWrapper<Discussion> discussionQueryWrapper = new QueryWrapper<>();
        discussionQueryWrapper
                .select("id", "uid", "gid")
                .eq("id", discussion.getId());

        Discussion oriDiscussion = discussionEntityService.getOne(discussionQueryWrapper);
        if(oriDiscussion == null) {
            throw new StatusNotFoundException("更新失败，该讨论不存在！");
        }

        Long gid = oriDiscussion.getGid();
        if(gid == null) {
            throw new StatusNotFoundException("更新失败，该讨论非团队讨论！");
        }

        Group group = groupEntityService.getById(gid);
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
        boolean isAdmin = SecurityUtils.getSubject().hasRole("admin");

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("添加失败，该团队不存在或已被封禁！");
        }

        if(!groupValidator.isGroupMember(userRolesVo.getUid(), gid) && !isRoot) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        UpdateWrapper<Discussion> discussionUpdateWrapper = new UpdateWrapper<>();
        discussionUpdateWrapper.set("title", discussion.getTitle())
                .set("content", discussion.getTitle())
                .set("description", discussion.getDescription())
                .set("category_id", discussion.getCategoryId())
                .set(isRoot || isProblemAdmin ||  isAdmin,
                        "top_priority", discussion.getTopPriority())
                .eq("id", discussion.getId());

        boolean isOk = discussionEntityService.update(discussionUpdateWrapper);
        if(!isOk) {
            throw new StatusFailException("修改失败");
        }
    }
}
