package com.github.loj.controller.msg;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.UserMsgVO;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;
import com.github.loj.service.msg.UserMessageService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.web.bind.annotation.*;

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

    /**
     * 获取评论我的讨论贴的消息，按未读的在前、时间晚的在前进行排序
     * @param limit
     * @param currentPage
     * @return
     */
    @GetMapping("/comment")
    @RequiresAuthentication
    public CommonResult<IPage<UserMsgVO>> getCommentMsg(@RequestParam(value = "limit", required = false) Integer limit,
                                                        @RequestParam(value = "currentPage", required = false) Integer currentPage) {
        return userMessageService.getCommentMsg(limit, currentPage);
    }

    @GetMapping("reply")
    public CommonResult<IPage<UserMsgVO>> getReplyMsg(@RequestParam(value = "limit", required = false) Integer limit,
                                                      @RequestParam(value = "currentPage", required = false) Integer currentPage) {
        return userMessageService.getReplyMsg(limit, currentPage);
    }

}
