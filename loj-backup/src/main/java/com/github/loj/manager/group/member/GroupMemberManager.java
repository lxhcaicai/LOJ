package com.github.loj.manager.group.member;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.dao.group.GroupMemberEntityService;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.entity.group.GroupMember;
import com.github.loj.pojo.vo.GroupMemberVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@Component
public class GroupMemberManager {

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private GroupMemberEntityService groupMemberEntityService;

    @Autowired
    private GroupValidator groupValidator;

    public IPage<GroupMemberVO> getMemberList(Integer limit, Integer currentPage, String keyword, Integer auth, Long gid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);
        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取成员列表失败，该团队不存在或已被封禁！");
        }

        if(!groupValidator.isGroupMember(userRolesVo.getUid(),gid) && !isRoot) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        if(auth == null ||auth < 1) {
            auth = 0;
        }

        if(!StringUtils.isEmpty(keyword)) {
            keyword = keyword.trim();
        }
        return groupMemberEntityService.getMemberList(limit,currentPage, keyword,auth,gid);
    }

    public IPage<GroupMemberVO>  getApplyList(Integer limit, Integer currentPage, String keyword, Integer auth, Long gid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);
        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取成员列表失败，该团队不存在或已被封禁！");
        }

        if(!groupValidator.isGroupMember(userRolesVo.getUid(),gid) && !isRoot) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        if(auth == null ||auth < 1) {
            auth = 0;
        }
        if(!StringUtils.isEmpty(keyword)) {
            keyword = keyword.trim();
        }

        return groupMemberEntityService.getApplyList(limit,currentPage,keyword,auth,gid);
    }

    public void addMember(Long gid, String code, String reason) throws StatusNotFoundException, StatusFailException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);

        if(group == null) {
            throw new StatusNotFoundException("添加成员失败，该团队不存在!");
        }

        if(!isRoot && (group.getStatus() == 1 || !group.getVisible())) {
            throw new StatusNotFoundException("添加成员失败，该团队已被封禁或未公开显示！");
        }

        if(group.getAuth() == 3 && !code.equals(group.getCode())) {
            throw new StatusFailException("邀请码错误，请重新尝试！");
        }

        if(group.getAuth() != 1 && !StringUtils.isEmpty(reason) && (reason.length() < 5 || reason.length() > 100)) {
            throw new StatusFailException("申请理由的长度应为 5 到 100！");
        }

        QueryWrapper<GroupMember> groupMemberQueryWrapper = new QueryWrapper<>();
        groupMemberQueryWrapper.eq("uid", userRolesVo.getUsername()).eq("gid", gid);

        GroupMember groupMember = groupMemberEntityService.getOne(groupMemberQueryWrapper);
        if(groupMember != null) {
            if (groupMember.getAuth() == 1) {
                throw new StatusForbiddenException("您已申请过，请勿重复申请！");
            } else if (groupMember.getAuth() >= 3) {
                throw new StatusForbiddenException("您已经加入了该团队，请勿再申请！！");
            }
        }

        GroupMember newGroupMember = new GroupMember();
        newGroupMember.setUid(userRolesVo.getUid()).setGid(gid).setReason(reason);
        if(group.getAuth() == 1) {
            newGroupMember.setAuth(3);
        } else {
            newGroupMember.setAuth(1);
        }

        boolean isOk = groupMemberEntityService.save(newGroupMember);

        if(!isOk) {
            throw new StatusFailException("申请失败，请重新尝试！");
        } else {
            if(group.getAuth() == 1) {
                groupMemberEntityService.addWelcomeNoticeToGroupNewMember(gid,group.getName(), userRolesVo.getUid());
            } else {
                groupMemberEntityService.addApplyNoticeToGroupRoot(gid,group.getName(), userRolesVo.getUid());
            }
        }
    }
}
