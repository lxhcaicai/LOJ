package com.github.loj.service.msg;

import com.github.loj.pojo.vo.UserUnreadMsgCountVO;

/**
 * @author lxhcaicai
 * @date 2023/5/14 21:01
 */
public interface MsgRemindEntityService {

    UserUnreadMsgCountVO getUserUnreadMsgCount(String uuid);

}
