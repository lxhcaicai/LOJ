package com.github.loj.service.msg.impl;

import com.github.loj.mapper.MsgRemindMapper;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;
import com.github.loj.service.msg.MsgRemindEntityService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/14 21:02
 */
@Service
public class MsgRemindEntityServiceImpl implements MsgRemindEntityService {

    @Resource
    private MsgRemindMapper msgRemindMapper;

    @Override
    public UserUnreadMsgCountVO getUserUnreadMsgCount(String uuid) {
        return msgRemindMapper.getUserUnreadMsgCount(uuid);
    }
}
