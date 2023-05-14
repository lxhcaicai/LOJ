package com.github.loj.service.msg;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;

/**
 * @author lxhcaicai
 * @date 2023/5/14 20:51
 */
public interface UserMessageService {

    public CommonResult<UserUnreadMsgCountVO> getUnreadMsgCount();

}
