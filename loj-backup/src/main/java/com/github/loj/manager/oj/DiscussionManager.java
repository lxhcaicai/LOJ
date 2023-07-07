package com.github.loj.manager.oj;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.annotation.LOJAccessEnum;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.config.NacosSwitchConfig;
import com.github.loj.config.SwitchConfig;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.dao.discussion.DiscussionLikeEntityService;
import com.github.loj.dao.discussion.DiscussionReportEntityService;
import com.github.loj.dao.problem.CategoryEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.user.UserAcproblemEntityService;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.entity.discussion.DiscussionLike;
import com.github.loj.pojo.entity.discussion.DiscussionReport;
import com.github.loj.pojo.entity.problem.Category;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.user.UserAcproblem;
import com.github.loj.pojo.vo.DiscussionVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.utils.RedisUtils;
import com.github.loj.validator.AccessValidator;
import com.github.loj.validator.CommonValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
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

    @Autowired
    private CommonValidator commonValidator;

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private UserAcproblemEntityService userAcproblemEntityService;

    @Autowired
    private DiscussionReportEntityService discussionReportEntityService;

    @Autowired
    private NacosSwitchConfig nacosSwitchConfig;

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private DiscussionLikeEntityService discussionLikeEntityService;

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

    public void addDiscussion(Discussion discussion) throws StatusFailException, StatusNotFoundException, StatusForbiddenException {

        commonValidator.validateContent(discussion.getTitle(), "讨论标题", 255);
        commonValidator.validateContent(discussion.getDescription(), "讨论描述", 255);
        commonValidator.validateContent(discussion.getContent(), "讨论", 65535);
        commonValidator.validateNotEmpty(discussion.getCategoryId(), "讨论分类");

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
        boolean isAdmin = SecurityUtils.getSubject().hasRole("admin");

        String problemId = discussion.getPid();
        if(problemId != null) {
            QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
            problemQueryWrapper.eq("problem_id",problemId);
            int problemCount = problemEntityService.count(problemQueryWrapper);
            if(problemCount == 0) {
                throw new StatusNotFoundException("对不起，该题目不存在，无法发布题解!");
            }
        }

        if(discussion.getGid() != null) {
            if(!isRoot
                && !discussion.getUid().equals(userRolesVo.getUid())
                && !groupValidator.isGroupMember(userRolesVo.getUid(), discussion.getGid())) {
                throw new StatusForbiddenException("对不起，您无权限操作！");
            }
        }

        // 除管理员外 其它用户需要AC20道题目以上才可发帖，同时限制一天只能发帖5次
        if(!isRoot && !isProblemAdmin && !isAdmin) {
            QueryWrapper<UserAcproblem> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("uid", userRolesVo.getUid()).select("distinct pid");
            int userAcProblemCount = userAcproblemEntityService.count(queryWrapper);
            SwitchConfig switchConfig = nacosSwitchConfig.getSwitchConfig();
            if(userAcProblemCount < switchConfig.getDefaultCreateDiscussionACInitValue()) {
                throw new StatusForbiddenException("对不起，您暂时不能评论！请先去提交题目通过" + switchConfig.getDefaultCreateDiscussionACInitValue() + "道以上!");
            }

            String lockKey = Constants.Account.DISCUSSION_ADD_NUM_LOCK.getCode() + userRolesVo.getUid();
            Integer num = (Integer) redisUtils.get(lockKey);
            if(num == null) {
                redisUtils.set(lockKey, 1, 3600 * 24);
            } else if(num >= switchConfig.getDefaultCreateDiscussionDailyLimit()) {
                throw new StatusForbiddenException("对不起，您今天发帖次数已超过" + switchConfig.getDefaultCreateDiscussionDailyLimit() + "次，已被限制！");
            } else {
                redisUtils.incr(lockKey, 1);
            }
        }

        discussion.setAuthor(userRolesVo.getUsername())
                .setAvatar(userRolesVo.getAvatar())
                .setUid(userRolesVo.getUid());

        if(SecurityUtils.getSubject().hasRole("root")) {
            discussion.setRole("root");
        } else if(SecurityUtils.getSubject().hasRole("admin")
                    || SecurityUtils.getSubject().hasRole("problem_admin")) {
            discussion.setRole("admin");
        } else {
            // 如果不是管理员角色，一律重置为不置顶
            discussion.setTopPriority(false);
        }

        boolean isOk = discussionEntityService.saveOrUpdate(discussion);
        if(!isOk) {
            throw new StatusFailException("发布失败，请重新尝试！");
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
                .select("id","uid","gid")
                .eq("id",discussion.getId());

        Discussion oriDiscussion = discussionEntityService.getOne(discussionQueryWrapper);
        if(oriDiscussion == null) {
            throw new StatusNotFoundException("更新失败，该讨论不存在！");
        }

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
        boolean isAdmin = SecurityUtils.getSubject().hasRole("admin");

        if (!isRoot
                && !oriDiscussion.getUid().equals(userRolesVo.getUid())
                && !(oriDiscussion.getGid() != null
                && groupValidator.isGroupAdmin(userRolesVo.getUid(), oriDiscussion.getGid()))) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }
        UpdateWrapper<Discussion> discussionUpdateWrapper = new UpdateWrapper<>();
        discussionUpdateWrapper.set("title", discussion.getTitle())
                .set("content", discussion.getContent())
                .set("description", discussion.getContent())
                .set("category_id", discussion.getCategoryId())
                .set(isRoot || isProblemAdmin || isAdmin,
                        "top_priority", discussion.getTopPriority())
                .eq("id", discussion.getId());
        boolean isOk = discussionEntityService.update(discussionUpdateWrapper);
        if(!isOk) {
            throw new StatusFailException("修改失败");
        }
    }

    public void removeDiscussion(Integer did) throws StatusNotFoundException, StatusForbiddenException, StatusFailException {
        QueryWrapper<Discussion> discussionQueryWrapper = new QueryWrapper<>();
        discussionQueryWrapper
                .select("id","uid", "gid")
                .eq("id", did);

        Discussion discussion = discussionEntityService.getOne(discussionQueryWrapper);
        if(discussion == null) {
            throw new StatusNotFoundException("删除失败，该讨论已不存在！");
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        if(!isRoot
                && !discussion.getUid().equals(userRolesVo.getUid())
                && !(discussion.getGid() != null
                && groupValidator.isGroupAdmin(userRolesVo.getUid(), discussion.getGid()))) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        UpdateWrapper<Discussion> discussionUpdateWrapper = new UpdateWrapper<Discussion>().eq("id", did);
        // 如果不是是管理员,则需要附加当前用户的uid条件
        if(!SecurityUtils.getSubject().hasRole("root")
                && !SecurityUtils.getSubject().hasRole("admin")
                && !SecurityUtils.getSubject().hasRole("problem_admin")) {
            discussionUpdateWrapper.eq("uid", userRolesVo.getUid());
        }
        boolean isOk = discussionEntityService.remove(discussionUpdateWrapper);
        if(!isOk) {
            throw new StatusFailException("删除失败，无权限或者该讨论不存在");
        }
    }
    @Transactional(rollbackFor = Exception.class)
    public void addDiscussionLike(Integer did, Boolean toLike) throws StatusNotFoundException, StatusForbiddenException, StatusFailException {

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        Discussion discussion = discussionEntityService.getById(did);

        if(discussion == null) {
            throw new StatusNotFoundException("对不起，该讨论不存在！");
        }

        if(discussion.getGid() != null) {
            boolean isRoot = SecurityUtils.getSubject().hasRole("root");
            if(!isRoot && ! discussion.getUid().equals(userRolesVo.getUid())
                    && !groupValidator.isGroupMember(userRolesVo.getUid(), discussion.getGid())) {
                throw new StatusForbiddenException("对不起，您无权限操作！");
            }
        }

        QueryWrapper<DiscussionLike> discussionLikeQueryWrapper = new QueryWrapper<>();
        discussionLikeQueryWrapper.eq("did", did).eq("uid", userRolesVo.getUid());

        DiscussionLike discussionLike = discussionLikeEntityService.getOne(discussionLikeQueryWrapper,false);

        if(toLike) {
            if(discussionLike == null) {
                boolean isSave = discussionLikeEntityService.saveOrUpdate(new DiscussionLike().setUid(userRolesVo.getUid()).setDid(did));
                if(!isSave) {
                    throw new StatusFailException("点赞失败，请重试尝试！");
                }
            }

            // 点赞 + 1
            UpdateWrapper<Discussion> discussionUpdateWrapper = new UpdateWrapper<>();
            discussionUpdateWrapper.eq("id", discussion.getId())
                    .setSql("like_num=like_num+1");
            discussionEntityService.update(discussionUpdateWrapper);
            // 当前帖子要不是点赞者的 才发送点赞消息
            if(!userRolesVo.getUid().equals(discussion.getAuthor())) {
                discussionEntityService.updatePostLikeMsg(discussion.getUid(),
                        userRolesVo.getUid(),
                        did,
                        discussion.getGid());
            }
        } else {
            // 取消点赞
            if(discussionLike != null) {
                boolean isDelete = discussionLikeEntityService.removeById(discussionLike.getId());
                if(!isDelete) {
                    throw new StatusFailException("取消点赞失败，请重试尝试！");
                }
            }
            // 点赞 - 1
            UpdateWrapper<Discussion> discussionUpdateWrapper = new UpdateWrapper<>();
            discussionUpdateWrapper.setSql("like_num=like_num-1").eq("id", did);
            discussionEntityService.update(discussionUpdateWrapper);
        }
    }

    public void addDiscussionReport(DiscussionReport discussionReport) throws StatusFailException {
        boolean isOk = discussionReportEntityService.saveOrUpdate(discussionReport);
        if(!isOk) {
            throw new StatusFailException("举报失败，请重新尝试");
        }
    }
}
