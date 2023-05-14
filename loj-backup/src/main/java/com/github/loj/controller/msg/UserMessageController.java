package com.github.loj.controller.msg;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;
import com.github.loj.service.msg.UserMessageService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/14 20:49
 */
@RestController
@RequestMapping("/api/msg")
public class UserMessageController {

    @Resource
    private UserMessageService userMessageService;


    /**
     *  获取用户的未读消息数量，包括评论我的、回复我的、收到的赞、系统通知、我的消息
     * @return
     */
    @RequestMapping(value = "/unread", method = RequestMethod.GET)
    @RequiresAuthentication
    public CommonResult<UserUnreadMsgCountVO> getUnreadMsgCount() {
        return userMessageService.getUnreadMsgCount();
    }

}
