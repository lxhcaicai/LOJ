package com.github.loj.dao.msg.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.msg.AdminSysNoticeEntityService;
import com.github.loj.mapper.AdminSysNoticeMapper;
import com.github.loj.pojo.entity.msg.AdminSysNotice;
import com.github.loj.pojo.vo.AdminSysNoticeVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/4/24 20:55
 */
@Service
public class AdminSysNoticeEntityServiceImpl extends ServiceImpl<AdminSysNoticeMapper, AdminSysNotice> implements AdminSysNoticeEntityService {

    @Resource
    private AdminSysNoticeMapper adminSysNoticeMapper;

    @Override
    public IPage<AdminSysNoticeVO> getSysNotice(int limit, int currentPage, String type) {
        Page<AdminSysNoticeVO> page = new Page<>(currentPage, limit);
        return adminSysNoticeMapper.getAdminSysNotice(page, type);
    }
}
