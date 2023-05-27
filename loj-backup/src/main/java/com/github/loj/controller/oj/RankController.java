package com.github.loj.controller.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.service.oj.RankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author lxhcaicai
 * @date 2023/5/26 23:48
 */
@RestController
@RequestMapping("/api")
@AnonApi
public class RankController {

    @Autowired
    private RankService rankService;

    @GetMapping("/get-rank-list")
    public CommonResult<IPage> getRankList(@RequestParam(value = "limit", required = false) Integer limit,
                                           @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                           @RequestParam(value = "searchUser", required = false) String searchUser,
                                           @RequestParam(value = "type", required = true) Integer type) {
        return rankService.getRankList(limit, currentPage, searchUser, type);
    }

}
