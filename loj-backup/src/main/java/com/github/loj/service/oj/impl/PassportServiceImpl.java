package com.github.loj.service.oj.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.PassportManager;
import com.github.loj.pojo.dto.LoginDTO;
import com.github.loj.pojo.vo.UserInfoVO;
import com.github.loj.service.oj.PassportService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author lxhcaicai
 * @date 2023/5/12 23:22
 */
@Service
public class PassportServiceImpl implements PassportService {

    @Resource
    private PassportManager passportManager;

    @Override
    public CommonResult<UserInfoVO> login(LoginDTO loginDTO, HttpServletResponse response, HttpServletRequest request) {
        try {
            return CommonResult.successResponse(passportManager.login(loginDTO, response, request));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> logout() {
        passportManager.logout();
        return CommonResult.successResponse("登出成功");
    }
}
