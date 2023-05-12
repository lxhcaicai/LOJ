package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.LoginDTO;
import com.github.loj.pojo.vo.UserInfoVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author lxhcaicai
 * @date 2023/5/12 23:21
 */
public interface PassportService {

    public CommonResult<UserInfoVO> login(LoginDTO loginDTO, HttpServletResponse response, HttpServletRequest request);

}
