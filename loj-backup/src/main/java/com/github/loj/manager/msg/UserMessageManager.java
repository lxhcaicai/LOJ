package com.github.loj.manager.msg;

import com.github.loj.pojo.vo.UserUnreadMsgCountVO;
import com.github.loj.service.msg.MsgRemindEntityService;
import com.github.loj.shiro.AccountProfile;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/14 20:58
 */
@Component
public class UserMessageManager {

    @Resource
    private MsgRemindEntityService msgRemindEntityService;

    public UserUnreadMsgCountVO getUnreadMsgCount() {
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        UserUnreadMsgCountVO userUnreadMsgCount = msgRemindEntityService.getUserUnreadMsgCount(userRolesVo.getUid());
        if(userUnreadMsgCount == null) {
            userUnreadMsgCount = new UserUnreadMsgCountVO(0, 0, 0, 0, 0);
        }
        return userUnreadMsgCount;
    }

}
