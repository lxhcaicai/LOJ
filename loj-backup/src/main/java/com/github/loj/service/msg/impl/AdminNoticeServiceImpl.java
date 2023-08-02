package com.github.loj.service.msg.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.msg.AdminNoticeManager;
import com.github.loj.pojo.vo.AdminSysNoticeVO;
import com.github.loj.service.msg.AdminNoticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService {

    @Resource
    private AdminNoticeManager adminNoticeManager;

    @Override
    public CommonResult<IPage<AdminSysNoticeVO>> getSysNotice(Integer limit, Integer currentPage, String type) {
        return CommonResult.successResponse(adminNoticeManager.getSysNotice(limit,currentPage,type));
    }
}
