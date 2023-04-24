package com.github.loj.service.account.impl;

import com.github.loj.common.exception.StatusAccessDeniedException;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.admin.account.AdminAccountManager;
import com.github.loj.pojo.dto.LoginDTO;
import com.github.loj.pojo.vo.UserInfoVO;
import com.github.loj.service.account.AdminAccountService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/4/24 2:01
 */
@Service
public class AdminAccountServiceImpl implements AdminAccountService {

    @Resource
    private AdminAccountManager adminAccountManager;

    @Override
    public CommonResult<UserInfoVO> login(LoginDTO loginDTO) {
        try {
            return CommonResult.successResponse(adminAccountManager.login(loginDTO));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusAccessDeniedException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.ACCESS_DENIED);
        }
    }

    @Override
    public CommonResult<Void> logout() {
        adminAccountManager.logout();;
        return CommonResult.successResponse("退出登录成功!");
    }
}
