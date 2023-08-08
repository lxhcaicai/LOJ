package com.github.loj.service.admin.announcement;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.AnnouncementVO;

public interface AdminAnnouncementService {

    CommonResult<IPage<AnnouncementVO>> getAnnouncementList(Integer limit, Integer currentPage);

}
