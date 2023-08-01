package com.github.loj.controller.msg;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;
import com.github.loj.service.msg.UserMessageService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

    /**
     * 根据type，清空各个消息模块的消息或单个消息
     * @param type
     * @param id
     * @return
     */
    @RequestMapping(value = "/clean", method = RequestMethod.DELETE)
    @RequiresAuthentication
    public CommonResult<Void> cleanMsg(@RequestParam("type") String type,
                                       @RequestParam(value = "id", required = false) Long id) {
        return userMessageService.cleanMsg(type, id);
    }

}
