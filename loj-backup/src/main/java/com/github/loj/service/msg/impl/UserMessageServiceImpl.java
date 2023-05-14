package com.github.loj.service.msg.impl;

import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.msg.UserMessageManager;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;
import com.github.loj.service.msg.UserMessageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/14 20:56
 */
@Service
public class UserMessageServiceImpl implements UserMessageService {

    @Resource
    private UserMessageManager userMessageManager;

    @Override
    public CommonResult<UserUnreadMsgCountVO> getUnreadMsgCount() {
        return CommonResult.successResponse(userMessageManager.getUnreadMsgCount());
    }
}
