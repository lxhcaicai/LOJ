package com.github.loj.dao.msg;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.msg.UserSysNotice;
import com.github.loj.pojo.vo.SysMsgVO;

/**
 * @author lxhcaicai
 * @date 2023/4/24 21:05
 */
public interface UserSysNoticeEntityService extends IService<UserSysNotice> {
    IPage<SysMsgVO> getSysNotice(int limit, int currentPage, String uid);

    IPage<SysMsgVO> getMineNotice(int limit, int currentPage, String uid);
}
