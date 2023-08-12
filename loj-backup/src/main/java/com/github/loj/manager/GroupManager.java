package com.github.loj.manager;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.vo.GroupVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@Component
public class GroupManager {

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private GroupValidator groupValidator;

    public IPage<GroupVO> getGroupList(Integer limit, Integer currentPage, String keyword, Integer auth, Boolean onlyMine) {

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        if(auth == null || auth < 1) {
            auth = 0;
        }
        if(!StringUtils.isEmpty(keyword)) {
            keyword = keyword.trim();
        }
        String uid = "";
        boolean isRoot = false;
        if(userRolesVo != null) {
            uid = userRolesVo.getUid();
            isRoot = SecurityUtils.getSubject().hasRole("root");
        }
        return groupEntityService.getGroupList(limit,currentPage,keyword,auth,uid,onlyMine,isRoot);
    }

    public Group getGroup(Long gid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);
        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("访问团队失败，该团队不存在或已被封禁！");
        }

        if(!group.getVisible() && !isRoot && !groupValidator.isGroupMember(userRolesVo.getUid(),gid)) {
            throw new StatusForbiddenException("该团队并非公开团队，不支持访问！");
        }

        if(!isRoot &&  !groupValidator.isGroupRoot(userRolesVo.getUid(),gid)) {
            group.setCode(null);
        }
        return group;
    }
}
