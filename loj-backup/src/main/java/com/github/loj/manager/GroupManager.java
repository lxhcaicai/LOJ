package com.github.loj.manager;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.pojo.vo.GroupVO;
import com.github.loj.shiro.AccountProfile;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@Component
public class GroupManager {

    @Autowired
    private GroupEntityService groupEntityService;

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
}
