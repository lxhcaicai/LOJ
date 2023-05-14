package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.pojo.vo.UserMsgVO;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @author lxhcaicai
 * @date 2023/5/14 21:04
 */
@Mapper
public interface MsgRemindMapper {

    UserUnreadMsgCountVO getUserUnreadMsgCount(@Param("uid") String uid);

    IPage<UserMsgVO> getUserMsg(Page<UserMsgVO> page, @Param("uid") String uid, @Param("action") String action);

}
