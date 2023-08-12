package com.github.loj.manager.group.member;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.dao.group.GroupMemberEntityService;
import com.github.loj.pojo.entity.group.Group;
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
}
