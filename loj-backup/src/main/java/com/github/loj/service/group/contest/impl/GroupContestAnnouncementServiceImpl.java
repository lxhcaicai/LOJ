package com.github.loj.service.group.contest.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.group.contest.GroupContestAnnouncementManager;
import com.github.loj.pojo.vo.AnnouncementVO;
import com.github.loj.service.group.contest.GroupContestAnnouncementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GroupContestAnnouncementServiceImpl implements GroupContestAnnouncementService {

    @Autowired
    private GroupContestAnnouncementManager groupContestAnnouncementManager;

    @Override
    public CommonResult<IPage<AnnouncementVO>> getContestAnnouncementList(Integer limit, Integer currentPage, Long cid) {
        try {
            return CommonResult.successResponse(groupContestAnnouncementManager.getContestAnnouncementList(limit,currentPage,cid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        }
    }
}
