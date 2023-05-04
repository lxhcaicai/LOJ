package com.github.loj.service.admin.user.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.user.AdminUserManager;
import com.github.loj.pojo.vo.UserRolesVO;
import com.github.loj.service.admin.user.AdminUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/5 0:55
 */
@Service
public class AdminUserServiceImpl implements AdminUserService {

    @Resource
    private AdminUserManager adminUserManager;

    @Override
    public CommonResult<IPage<UserRolesVO>> getUserList(Integer limit, Integer currentPage, Boolean onlyAdmin, String keyword) {
        return CommonResult.successResponse(adminUserManager.getUserList(limit, currentPage, onlyAdmin, keyword));
    }
}
