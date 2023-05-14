package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.ACMRankVO;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.pojo.vo.RecentUpdatedProblemVO;

import java.util.HashMap;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/14 21:34
 */

public interface HomeService {
    public CommonResult<List<HashMap<String,Object>>> getHomeCarousel();

    public CommonResult<List<ContestVO>> getRecentContest();

    public CommonResult<List<ACMRankVO>> getRecentSevenACRank();

    public CommonResult<List<RecentUpdatedProblemVO>> getRecentUpdatedProblemList();
}
