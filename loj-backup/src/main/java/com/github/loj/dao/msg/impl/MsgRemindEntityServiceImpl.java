package com.github.loj.dao.msg.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.msg.MsgRemindEntityService;
import com.github.loj.mapper.MsgRemindMapper;
import com.github.loj.pojo.entity.msg.MsgRemind;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class MsgRemindEntityServiceImpl extends ServiceImpl<MsgRemindMapper, MsgRemind> implements MsgRemindEntityService {
    @Resource
    private MsgRemindMapper msgRemindMapper;

    @Override
    public UserUnreadMsgCountVO getUserUnreadMsgCount(String uid) {
        return msgRemindMapper.getUserUnreadMsgCount(uid);
    }
}
