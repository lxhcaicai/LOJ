package com.github.loj.controller.oj;

import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.ContestScrollBoardInfoVO;
import com.github.loj.pojo.vo.ContestScrollBoardSubmissionVO;
import com.github.loj.service.oj.ContestScrollBoardService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/api")
@AnonApi
public class ContestScrollBoardController {

    @Resource
    private ContestScrollBoardService contestScrollBoardService;

    /**
     * 获取比赛滚榜信息
     * @param cid
     * @return
     */
    @GetMapping("/get-contest-scroll-board-info")
    public CommonResult<ContestScrollBoardInfoVO> getContestScrollBoardInfo(@RequestParam(value = "cid") Long cid) {
        return contestScrollBoardService.getContestScrollBoardInfo(cid);
    }

    /**
     * 取比赛滚榜提交信息
     * @param cid
     * @param removeStar
     * @return
     */
    @GetMapping("/get-contest-scroll-board-submission")
    public CommonResult<List<ContestScrollBoardSubmissionVO>> getContestScrollBoardSubmission(
            @RequestParam(value = "cid", required = true) Long cid,
            @RequestParam(value = "removeStar", defaultValue = "false") Boolean removeStar) {
        return contestScrollBoardService.getContestScrollBoardSubmission(cid,removeStar);
    }
}
