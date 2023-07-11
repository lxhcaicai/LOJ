package com.github.loj.service.oj.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.AccountManager;
import com.github.loj.pojo.dto.CheckUsernameOrEmailDTO;
import com.github.loj.pojo.vo.CheckUsernameOrEmailVO;
import com.github.loj.pojo.vo.UserAuthInfoVO;
import com.github.loj.pojo.vo.UserCalendarHeatmapVO;
import com.github.loj.pojo.vo.UserHomeVO;
import com.github.loj.service.oj.AccountService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/13 22:00
 */
@Service
public class AccountServiceImpl implements AccountService {

    @Resource
    private AccountManager accountManager;

    @Override
    public CommonResult<CheckUsernameOrEmailVO> checkUsernameOrEmail(CheckUsernameOrEmailDTO checkUsernameOrEmailDTO) {
        return CommonResult.successResponse(accountManager.checkUsernameOrEmail(checkUsernameOrEmailDTO));
    }

    @Override
    public CommonResult<UserAuthInfoVO> getUserAuthInfo() {
        return CommonResult.successResponse(accountManager.getUserAuthInfo());
    }

    @Override
    public CommonResult<UserCalendarHeatmapVO> getUserCalendarHeatmap(String uid, String username) {
        try {
            return CommonResult.successResponse(accountManager.getUserCalendarHeatmap(uid, username));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<UserHomeVO> getUserHomeInfo(String uid, String username) {
        try {
            return CommonResult.successResponse(accountManager.getUserHomeInfo(uid,username));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
