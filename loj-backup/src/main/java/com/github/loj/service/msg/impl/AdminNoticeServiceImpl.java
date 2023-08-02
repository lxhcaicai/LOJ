package com.github.loj.service.msg.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.msg.AdminNoticeManager;
import com.github.loj.pojo.entity.msg.AdminSysNotice;
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

    @Override
    public CommonResult<Void> addSysNotice(AdminSysNotice adminSysNotice) {
        try {
            adminNoticeManager.addSysNotice(adminSysNotice);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> updateSysNotice(AdminSysNotice adminSysNotice) {
        try {
            adminNoticeManager.updateSysNotice(adminSysNotice);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Void> deleteSysNotice(Long id) {
        try {
            adminNoticeManager.deleteSysNotice(id);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
