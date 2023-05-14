package com.github.loj.controller.oj;

import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.service.oj.HomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;

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

}
