package com.github.loj.dao.user;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.user.Role;
import com.github.loj.pojo.entity.user.UserRole;
import com.github.loj.pojo.vo.UserRolesVO;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/22 2:33
 */
public interface UserRoleEntityService extends IService<UserRole> {
    UserRolesVO getUserRoles(String uid, String username);

    List<Role> getRolesByUid(String uid);

    IPage<UserRolesVO> getUserList(int limit, int currentPage, String keyword, Boolean onlyAdmin);

    void deleteCache(String uid, boolean isRemoveSession);

    String getAuthChangeContent(int oldType, int newType);
}
