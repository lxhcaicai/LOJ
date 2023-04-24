package com.github.loj.controller.admin;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.LoginDTO;
import com.github.loj.pojo.vo.UserInfoVO;
import com.github.loj.service.account.AdminAccountService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


/**
 * @author lxhcaicai
 * @date 2023/4/20 2:07
 */

@RestController
@RequestMapping("/api/admin")
public class AdminAccountController {

    @Autowired
    private AdminAccountService adminAccountService;

    @RequestMapping("/login")
    public CommonResult<UserInfoVO> login(@Validated @RequestBody LoginDTO loginDTO) {
        return adminAccountService.login(loginDTO);
    }

    @GetMapping("/logout")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> logout() {
        return adminAccountService.logout();
    }
}
