package com.github.loj.service.admin.contest.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.contest.AdminContestAnnouncementManager;
import com.github.loj.pojo.vo.AnnouncementVO;
import com.github.loj.service.admin.contest.AdminContestAnnouncementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminContestAnnouncementServiceImpl implements AdminContestAnnouncementService {

    @Autowired
    private AdminContestAnnouncementManager adminContestAnnouncementManager;

    @Override
    public CommonResult<IPage<AnnouncementVO>> getAnnouncementList(Integer limit, Integer currentPage, Long cid) {
        IPage<AnnouncementVO>  announcementList = adminContestAnnouncementManager.getAnnouncementList(limit, currentPage, cid);
        return CommonResult.successResponse(announcementList);
    }
}
