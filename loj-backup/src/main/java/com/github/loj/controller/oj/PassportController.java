package com.github.loj.controller.oj;

import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ApplyResetPasswordDTO;
import com.github.loj.pojo.dto.LoginDTO;
import com.github.loj.pojo.dto.RegisterDTO;
import com.github.loj.pojo.dto.ResetPasswordDTO;
import com.github.loj.pojo.vo.RegisterCodeVO;
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

    @PostMapping("/apply-reset-password")
    @AnonApi
    public CommonResult<Void> applyResetPassword(@RequestBody ApplyResetPasswordDTO applyResetPasswordDTO) {
        return passportService.applyResetPassword(applyResetPasswordDTO);
    }

    /**
     * 获取注册验证码
     * @param email
     * @return
     */
    @RequestMapping(value = "/get-register-code", method = RequestMethod.GET)
    @AnonApi
    public CommonResult<RegisterCodeVO> getRegisterCode(@RequestParam(value = "email", required = true) String email) {
        return passportService.getRegisterCode(email);
    }

    /**
     * 注册逻辑，具体参数请看RegisterDto类
     * @param registerDTO
     * @return
     */
    @PostMapping("/register")
    @AnonApi
    public CommonResult<Void> register(@RequestBody RegisterDTO registerDTO) {
        return passportService.register(registerDTO);
    }

    @PostMapping("/reset-password")
    @AnonApi
    public CommonResult<Void> resetPassword(@RequestBody ResetPasswordDTO resetPasswordDTO) {
        return passportService.resetPassword(resetPasswordDTO);
    }

}
