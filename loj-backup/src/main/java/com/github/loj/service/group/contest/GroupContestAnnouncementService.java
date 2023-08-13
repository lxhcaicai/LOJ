package com.github.loj.service.group.contest;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.AnnouncementDTO;
import com.github.loj.pojo.vo.AnnouncementVO;

public interface GroupContestAnnouncementService {
    public CommonResult<IPage<AnnouncementVO>> getContestAnnouncementList(Integer limit, Integer currentPage, Long cid);

    public CommonResult<Void> addContestAnnouncement(AnnouncementDTO announcementDto);

    public CommonResult<Void> updateContestAnnouncement(AnnouncementDTO announcementDto);

    public CommonResult<Void> deleteContestAnnouncement(Long aid, Long cid);
}
