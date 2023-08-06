package com.github.loj.service.admin.contest;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.AnnouncementVO;

public interface AdminContestAnnouncementService {

    CommonResult<IPage<AnnouncementVO>> getAnnouncementList(Integer limit, Integer currentPage, Long cid);

}
