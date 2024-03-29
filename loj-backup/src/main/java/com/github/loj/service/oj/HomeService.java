package com.github.loj.service.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/5/14 21:34
 */

public interface HomeService {
    public CommonResult<List<HashMap<String,Object>>> getHomeCarousel();

    public CommonResult<List<ContestVO>> getRecentContest();

    public CommonResult<List<ACMRankVO>> getRecentSevenACRank();

    public CommonResult<List<RecentUpdatedProblemVO>> getRecentUpdatedProblemList();

    public CommonResult<Map<Object,Object>> getWebConfig();

    public CommonResult<IPage<AnnouncementVO>> getCommonAnnouncement(Integer limit, Integer currentPage);

    public CommonResult<SubmissionStatisticsVO> getLastWeekSubmissionStatistics(Boolean forceRefresh);

    @Deprecated
    public CommonResult<List<HashMap<String,Object>>> getRecentOtherContest();
}
