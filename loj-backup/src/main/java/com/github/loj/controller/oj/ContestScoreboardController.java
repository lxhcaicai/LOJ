package com.github.loj.controller.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ContestRankDTO;
import com.github.loj.pojo.vo.ContestOutsideInfoVO;
import com.github.loj.service.oj.ContestScoreboardService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/api")
@AnonApi
public class ContestScoreboardController {

    @Resource
    private ContestScoreboardService contestScoreboardService;

    /**
     * 提供比赛外榜排名数据
     * @param contestRankDTO
     * @return
     */
    @PostMapping("/get-contest-outside-scoreboard")
    public CommonResult<IPage> getContestOutsideScoreboard(@RequestBody ContestRankDTO contestRankDTO) {
        return contestScoreboardService.getContestOutsideScoreboard(contestRankDTO);
    }

    /**
     * 提供比赛外榜所需的比赛信息和题目信息
     * @param cid
     * @return
     */
    @GetMapping("/get-contest-outsize-info")
    public CommonResult<ContestOutsideInfoVO> getContestOutsideInfo(@RequestParam(value = "cid", required = false) Long cid) {
        return contestScoreboardService.getContestOutsideInfo(cid);
    }
}
