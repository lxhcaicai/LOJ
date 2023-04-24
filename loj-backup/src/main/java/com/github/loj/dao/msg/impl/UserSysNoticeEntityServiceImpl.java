package com.github.loj.dao.msg.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.msg.UserSysNoticeEntityService;
import com.github.loj.mapper.UserSysNoticeMapper;
import com.github.loj.pojo.entity.msg.UserSysNotice;
import com.github.loj.pojo.vo.SysMsgVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/4/24 21:20
 */
@Service
public class UserSysNoticeEntityServiceImpl extends ServiceImpl<UserSysNoticeMapper, UserSysNotice> implements UserSysNoticeEntityService {

    @Resource
    private UserSysNoticeMapper userSysNoticeMapper;

    @Override
    public IPage<SysMsgVO> getSysNotice(int limit, int currentPage, String uid) {
        Page<SysMsgVO> page = new Page<>(currentPage, limit);
        return userSysNoticeMapper.getSysOrMineNotice(page, uid, "Sys");
    }

    @Override
    public IPage<SysMsgVO> getMineNotice(int limit, int currentPage, String uid) {
        Page<SysMsgVO> page = new Page<>(currentPage, limit);
        return userSysNoticeMapper.getSysOrMineNotice(page, uid, "Mine");
    }
}
