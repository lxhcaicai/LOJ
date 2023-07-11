package com.github.loj.controller.oj;

import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.CheckUsernameOrEmailDTO;
import com.github.loj.pojo.vo.CheckUsernameOrEmailVO;
import com.github.loj.pojo.vo.UserAuthInfoVO;
import com.github.loj.pojo.vo.UserCalendarHeatmapVO;
import com.github.loj.service.oj.AccountService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author lxhcaicai
 * @date 2023/5/13 21:54
 */
@RestController
@RequestMapping("/api")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @RequestMapping(value = "/check-username-or-email", method = RequestMethod.POST)
    @AnonApi
    public CommonResult<CheckUsernameOrEmailVO> checkUsernameOrEmail(@RequestBody CheckUsernameOrEmailDTO checkUsernameOrEmailDTO) {
        return accountService.checkUsernameOrEmail(checkUsernameOrEmailDTO);
    }


    /**
     * 获取用户权限信息
     * @return
     */
    @GetMapping("/get-user-auth-info")
    @RequiresAuthentication
    public CommonResult<UserAuthInfoVO> getUserAuthInfo() {
        return accountService.getUserAuthInfo();
    }

    /**
     * 获取用户最近一年的提交热力图数据
     * @param uid
     * @param username
     * @return
     */
    @GetMapping("/get-user-calendar-heatmap")
    @AnonApi
    public CommonResult<UserCalendarHeatmapVO> getUserCalendarHeatmap(@RequestParam(value = "uid", required = false) String uid,
                                                                     @RequestParam(value = "username",required = false) String username) {
        return accountService.getUserCalendarHeatmap(uid, username);
    }
}
