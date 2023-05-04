package com.github.loj.manager.admin.user;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.dao.user.UserRoleEntityService;
import com.github.loj.pojo.vo.UserRolesVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @author lxhcaicai
 * @date 2023/5/5 0:56
 */
@Component
@Slf4j(topic = "loj")
public class AdminUserManager {
    @Autowired
    private UserRoleEntityService userRoleEntityService;

    public IPage<UserRolesVO> getUserList(Integer limit, Integer currentPage, Boolean onlyAdmin, String keyword) {
        if(currentPage == null|| currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        if(keyword != null) {
            keyword = keyword.trim();
        }
        return userRoleEntityService.getUserList(limit, currentPage, keyword, onlyAdmin);
    }
}
