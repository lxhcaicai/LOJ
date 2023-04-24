package com.github.loj.service.account;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.LoginDTO;
import com.github.loj.pojo.vo.UserInfoVO;

/**
 * @author lxhcaicai
 * @date 2023/4/24 1:51
 */
public interface AdminAccountService {

    public CommonResult<UserInfoVO> login(LoginDTO loginDTO);

    public CommonResult<Void> logout();
}
