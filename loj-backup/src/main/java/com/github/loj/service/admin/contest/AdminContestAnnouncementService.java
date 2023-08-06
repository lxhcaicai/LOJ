package com.github.loj.service.admin.contest;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.AnnouncementDTO;
import com.github.loj.pojo.vo.AnnouncementVO;

public interface AdminContestAnnouncementService {

    public CommonResult<IPage<AnnouncementVO>> getAnnouncementList(Integer limit, Integer currentPage, Long cid);

    public CommonResult<Void> deleteAnnouncement(Long aid);

    public CommonResult<Void> addAnnouncement(AnnouncementDTO announcementDTO);
}
