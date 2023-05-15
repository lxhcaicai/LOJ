package com.github.loj.controller.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.*;
import com.github.loj.service.oj.HomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/5/14 21:30
 */
@RestController
@RequestMapping("/api")
@AnonApi
public class HomeController {

    @Autowired
    private HomeService homeService;

    /**
     * 获取主页轮播图
     * @return
     */
    @GetMapping("/home-carousel")
    public CommonResult<List<HashMap<String,Object>>> getHomeCarousel() {
        return homeService.getHomeCarousel();
    }

    /**
     * 获取最近14天的比赛信息列表
     * @return
     */
    @GetMapping("/get-recent-contest")
    public CommonResult<List<ContestVO>> getRecentContest() {
        return homeService.getRecentContest();
    }

    /**
     * 获取最近7天用户做题榜单
     * @return
     */
    @GetMapping("/get-recent-seven-ac-rank")
    public CommonResult<List<ACMRankVO>> getRecentSevenACRank() {
        return homeService.getRecentSevenACRank();
    }

    /**
     * 获取最近前十更新的题目（不包括比赛题目、私有题目）
     * @return
     */
    @GetMapping("/get-recent-updated-problem")
    public CommonResult<List<RecentUpdatedProblemVO>> getRecentUpdatedProblemList() {
        return homeService.getRecentUpdatedProblemList();
    }


    /**
     * 获取网站的基础配置。例如名字，缩写名字等等。
     * @return
     */
    @GetMapping("/get-website-config")
    public CommonResult<Map<Object, Object>> getWebConfig() {
        return homeService.getWebConfig();
    }


    /**
     * 获取主页公告列表
     * @param limit
     * @param currentPage
     * @return
     */
    @GetMapping("/get-common-announcement")
    public CommonResult<IPage<AnnouncementVO>> getCommonAnnouncement(@RequestParam(value = "limit", required = false) Integer limit,
                                                                     @RequestParam(value = "currentPage", required = false) Integer currentPage) {
        return homeService.getCommonAnnouncement(limit, currentPage);
    }

    /**
     * 获取最近一周提交统计
     * @param forceRefresh
     * @return
     */
    @GetMapping("/get-last-week-submission-statistics")
    public CommonResult<SubmissionStatisticsVO> getLastWeekSubmissionStatistics(
            @RequestParam(value = "forceRefresh", defaultValue = "false") Boolean forceRefresh) {
        return homeService.getLastWeekSubmissionStatistics(forceRefresh);
    }

}
