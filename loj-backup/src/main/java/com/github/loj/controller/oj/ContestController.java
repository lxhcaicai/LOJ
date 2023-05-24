package com.github.loj.controller.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ContestRankDTO;
import com.github.loj.pojo.vo.AnnouncementVO;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.pojo.vo.JudgeVO;
import com.github.loj.service.oj.ContestService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author lxhcaicai
 * @date 2023/5/17 22:54
 */
@RestController
@RequestMapping("/api")
public class ContestController {

    @Autowired
    private ContestService contestService;


    /**
     *  获取比赛列表分页数据
     * @param limit
     * @param currentPage
     * @param status
     * @param type
     * @param keyword
     * @return
     */
    @GetMapping("/get-contest-list")
    @AnonApi
    public CommonResult<IPage<ContestVO>> getContestList(@RequestParam(value = "limit", required = false) Integer limit,
                                                         @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                         @RequestParam(value = "status", required = false) Integer status,
                                                         @RequestParam(value = "type", required = false) Integer type,
                                                         @RequestParam(value = "keyword", required = false) String keyword) {
        return contestService.getContestList(limit, currentPage, status, type, keyword);
    }


    /**
     * 获得指定比赛的详细信息
     * @param cid
     * @return
     */
    @GetMapping("get-contest-info")
    @RequiresAuthentication
    public CommonResult<ContestVO> getContestInfo(@RequestParam(value = "cid", required = true) Long cid) {
        return contestService.getContestInfo(cid);
    }

    /**
     * 获取比赛提交代码信息
     * @param limit
     * @param currentPage
     * @param onlyMine
     * @param displayId
     * @param searchStatus
     * @param searchUsername
     * @param searchCid
     * @param beforeContestSubmit
     * @param completeProblemID
     * @return
     */
    @GetMapping("/contest-submissions")
    @RequiresAuthentication
    public CommonResult<IPage<JudgeVO>> getContestSubmissionList(@RequestParam(value = "limit", required = false) Integer limit,
                                                                 @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                                 @RequestParam(value = "onlyMine", required = false) Boolean onlyMine,
                                                                 @RequestParam(value = "problemID", required = false) String displayId,
                                                                 @RequestParam(value = "status", required = false) Integer searchStatus,
                                                                 @RequestParam(value = "username", required = false) String searchUsername,
                                                                 @RequestParam(value = "contestID", required = true) Long searchCid,
                                                                 @RequestParam(value = "beforeContestSubmit", required = true) Boolean beforeContestSubmit,
                                                                 @RequestParam(value = "completeProblemID", defaultValue = "false") Boolean completeProblemID) {


        return contestService.getContestSubmissionList(limit,
                currentPage,
                onlyMine,
                displayId,
                searchStatus,
                searchUsername,
                searchCid,
                beforeContestSubmit,
                completeProblemID);
    }

    /**
     * 获得比赛做题记录以用来排名
     * @param contestRankDTO
     * @return
     */
    @PostMapping("/get-contest-rank")
    @RequiresAuthentication
    public CommonResult<IPage> getContestRank(@RequestBody ContestRankDTO contestRankDTO) {
        return contestService.getContestRank(contestRankDTO);
    }

    /**
     * 获得比赛的通知列表
     * @param cid
     * @param limit
     * @param currentPage
     * @return
     */
    @GetMapping("/get-contest-announcement")
    @RequiresAuthentication
    public CommonResult<IPage<AnnouncementVO>> getContestAnnouncement(@RequestParam(value = "cid", required = true) Long cid,
                                                                      @RequestParam(value = "limit", required = false) Integer limit,
                                                                      @RequestParam(value = "currentPage", required = false) Integer currentPage) {
        return contestService.getContestAnnouncement(cid, limit, currentPage);
    }
}
