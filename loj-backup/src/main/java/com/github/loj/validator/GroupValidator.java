package com.github.loj.validator;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.dao.group.GroupMemberEntityService;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.entity.group.GroupMember;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @author lxhcaicai
 * @date 2023/5/7 18:00
 */
@Component
public class GroupValidator {

    @Autowired
    private GroupMemberEntityService groupMemberEntityService;

    @Autowired
    private GroupEntityService groupEntityService;

    public boolean isGroupMember(String uid, Long gid) {
        QueryWrapper<GroupMember> groupMemberQueryWrapper = new QueryWrapper<>();
        groupMemberQueryWrapper.eq("gid", gid).eq("uid", uid).in("auth", 3, 4, 5);

        GroupMember groupMember = groupMemberEntityService.getOne(groupMemberQueryWrapper, false);

        return groupMember != null || isGroupOwner(uid,gid);
    }

    public boolean isGroupAdmin(String uid, Long gid) {
        QueryWrapper<GroupMember> groupMemberQueryWrapper = new QueryWrapper<>();
        groupMemberQueryWrapper.eq("gid", gid).eq("uid", uid).in("auth", 4, 5);
        GroupMember groupMember = groupMemberEntityService.getOne(groupMemberQueryWrapper, false);

        return groupMember != null || isGroupOwner(uid, gid);
    }

    public boolean isGroupRoot(String uid, Long gid) {
        QueryWrapper<GroupMember> groupMemberQueryWrapper = new QueryWrapper<>();
        groupMemberQueryWrapper.eq("gid", gid).eq("uid", uid).eq("auth", 5);

        GroupMember groupMember = groupMemberEntityService.getOne(groupMemberQueryWrapper, false);

        return groupMember != null;
    }

    public boolean isGroupOwner(String uid, Long gid) {
        Group group = groupEntityService.getById(gid);

        return group != null && uid.equals(group.getUid());
    }
}
