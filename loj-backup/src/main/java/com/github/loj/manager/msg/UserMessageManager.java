package com.github.loj.manager.msg;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.msg.MsgRemindEntityService;
import com.github.loj.dao.msg.UserSysNoticeEntityService;
import com.github.loj.pojo.entity.msg.MsgRemind;
import com.github.loj.pojo.entity.msg.UserSysNotice;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;
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

    @Resource
    private UserSysNoticeEntityService userSysNoticeEntityService;

    public UserUnreadMsgCountVO getUnreadMsgCount() {
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        UserUnreadMsgCountVO userUnreadMsgCount = msgRemindEntityService.getUserUnreadMsgCount(userRolesVo.getUid());
        if(userUnreadMsgCount == null) {
            userUnreadMsgCount = new UserUnreadMsgCountVO(0, 0, 0, 0, 0);
        }
        return userUnreadMsgCount;
    }

    public void cleanMsg(String type, Long id) throws StatusFailException {

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isOk = cleanMsgByType(type, id, userRolesVo.getUid());
        if(!isOk) {
            throw new StatusFailException("清空失败");
        }
    }


    private boolean cleanMsgByType(String type, Long id, String uid) {

        switch (type) {
            case "Like":
            case "Discuss":
            case "Reply":
                UpdateWrapper<MsgRemind> updateWrapper1 = new UpdateWrapper<>();
                updateWrapper1
                        .eq(id != null, "id", id)
                        .eq("recipient_id", uid);
                return msgRemindEntityService.remove(updateWrapper1);
            case "Sys":
            case "Mine":
                UpdateWrapper<UserSysNotice> updateWrapper2 = new UpdateWrapper<>();
                updateWrapper2
                        .eq(id != null, "id", id)
                        .eq("recipient_id", uid);
                return userSysNoticeEntityService.remove(updateWrapper2);
        }
        return false;
    }
}
