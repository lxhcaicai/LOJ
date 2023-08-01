package com.github.loj.dao.msg;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.msg.MsgRemind;
import com.github.loj.pojo.vo.UserMsgVO;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;

public interface MsgRemindEntityService extends IService<MsgRemind> {
    UserUnreadMsgCountVO getUserUnreadMsgCount(String uid);

    IPage<UserMsgVO> getUserMsg(Page<UserMsgVO> page, String uid, String action);
}
