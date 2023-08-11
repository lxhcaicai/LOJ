package com.github.loj.service.group.announcement;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.common.Announcement;
import com.github.loj.pojo.vo.AnnouncementVO;

public interface GroupAnnouncementService {

    public CommonResult<IPage<AnnouncementVO>> getAnnouncementList(Integer limit, Integer currentPage, Long gid);

    public CommonResult<IPage<AnnouncementVO>> getAdminAnnouncementList(Integer limit, Integer currentPage, Long gid);

    public CommonResult<Void> addAnnouncement(Announcement announcement);
}
