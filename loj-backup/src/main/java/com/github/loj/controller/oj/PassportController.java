package com.github.loj.controller.oj;

import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.LoginDTO;
import com.github.loj.pojo.vo.UserInfoVO;
import com.github.loj.service.oj.PassportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author lxhcaicai
 * @date 2023/5/12 23:15
 * 处理登录、注册、重置密码
 */
@RestController
@RequestMapping("/api")
public class PassportController {

    @Autowired
    private PassportService passportService;

    @PostMapping("/login")
    @AnonApi
    public CommonResult<UserInfoVO> login(@Validated @RequestBody LoginDTO loginDTO, HttpServletResponse response, HttpServletRequest request) {
        return passportService.login(loginDTO, response, request);
    }
}
