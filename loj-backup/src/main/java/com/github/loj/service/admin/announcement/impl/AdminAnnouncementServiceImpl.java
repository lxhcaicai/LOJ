package com.github.loj.service.admin.announcement.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.announce.AdminAnnouncementManager;
import com.github.loj.pojo.vo.AnnouncementVO;
import com.github.loj.service.admin.announcement.AdminAnnouncementService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AdminAnnouncementServiceImpl implements AdminAnnouncementService {

    @Resource
    private AdminAnnouncementManager adminAnnouncementManager;

    @Override
    public CommonResult<IPage<AnnouncementVO>> getAnnouncementList(Integer limit, Integer currentPage) {
        return CommonResult.successResponse(adminAnnouncementManager.getAnnouncementList(limit,currentPage));
    }
}
