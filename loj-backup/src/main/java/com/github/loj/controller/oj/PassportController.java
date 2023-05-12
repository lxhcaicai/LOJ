package com.github.loj.controller.oj;

import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.LoginDTO;
import com.github.loj.pojo.vo.UserInfoVO;
import com.github.loj.service.oj.PassportService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

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

    /**
     * 退出逻辑，将jwt在redis中清除，下次需要再次登录。
     * @return
     */
    @GetMapping("/logout")
    @RequiresAuthentication
    public CommonResult<Void> logout() {
        return passportService.logout();
    }
}
