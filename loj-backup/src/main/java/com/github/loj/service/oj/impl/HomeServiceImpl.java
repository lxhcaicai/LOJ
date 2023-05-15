package com.github.loj.service.oj.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.HomeManager;
import com.github.loj.pojo.vo.ACMRankVO;
import com.github.loj.pojo.vo.AnnouncementVO;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.pojo.vo.RecentUpdatedProblemVO;
import com.github.loj.service.oj.HomeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/5/14 21:35
 */
@Service
public class HomeServiceImpl implements HomeService {

    @Resource
    private HomeManager homeManager;

    @Override
    public CommonResult<List<HashMap<String, Object>>> getHomeCarousel() {
        return CommonResult.successResponse(homeManager.getHomeCarousel());
    }

    @Override
    public CommonResult<List<ContestVO>> getRecentContest() {
        return CommonResult.successResponse(homeManager.getRecentContest());
    }

    @Override
    public CommonResult<List<ACMRankVO>> getRecentSevenACRank() {
        return CommonResult.successResponse(homeManager.getRecentSevenACRank());
    }

    @Override
    public CommonResult<List<RecentUpdatedProblemVO>> getRecentUpdatedProblemList() {
        return CommonResult.successResponse(homeManager.getRecentUpdatedProblemList());
    }

    @Override
    public CommonResult<Map<Object, Object>> getWebConfig() {
        return CommonResult.successResponse(homeManager.getWebConfig());
    }

    @Override
    public CommonResult<IPage<AnnouncementVO>> getCommonAnnouncement(Integer limit, Integer currentPage) {
        return CommonResult.successResponse(homeManager.getCommonAnnouncement(limit, currentPage));
    }
}
