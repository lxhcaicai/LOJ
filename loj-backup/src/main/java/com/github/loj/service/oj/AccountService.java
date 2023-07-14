package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ChangePasswordDTO;
import com.github.loj.pojo.dto.CheckUsernameOrEmailDTO;
import com.github.loj.pojo.vo.*;

/**
 * @author lxhcaicai
 * @date 2023/5/13 22:00
 */
public interface AccountService {

    public CommonResult<CheckUsernameOrEmailVO> checkUsernameOrEmail(CheckUsernameOrEmailDTO checkUsernameOrEmailDTO);

    public CommonResult<UserAuthInfoVO> getUserAuthInfo();

    public CommonResult<UserCalendarHeatmapVO> getUserCalendarHeatmap(String uid, String username);

    public CommonResult<UserHomeVO> getUserHomeInfo(String uid, String username);

    public CommonResult<Void> getChangeEmailCode(String email);

    public CommonResult<UserInfoVO> changeUserInfo(UserInfoVO userInfoVO);

    public CommonResult<ChangeAccountVO> changePassword(ChangePasswordDTO changePasswordDTO);

}
