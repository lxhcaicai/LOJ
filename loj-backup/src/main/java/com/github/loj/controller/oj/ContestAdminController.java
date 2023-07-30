package com.github.loj.controller.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.CheckACDTO;
import com.github.loj.pojo.entity.contest.ContestPrint;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.service.oj.ContestAdminService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class ContestAdminController {

    @Autowired
    private ContestAdminService contestAdminService;

    /**
     * 获取各个用户的ac情况，仅限于比赛管理者可查看
     * @param cid
     * @param currentPage
     * @param limit
     * @return
     */
    @GetMapping("/get-contest-ac-info")
    @RequiresAuthentication
    public CommonResult<IPage<ContestRecord>> getContestACInfo(@RequestParam("cid") Long cid,
                                                               @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                               @RequestParam(value = "limit", required = false) Integer limit) {
        return contestAdminService.getContestACInfo(cid,currentPage, limit);
    }

    /**
     * 获取比赛提交的的内容
     * @param cid
     * @param currentPage
     * @param limit
     * @return
     */
    @GetMapping("/get-contest-print")
    @RequiresAuthentication
    public CommonResult<IPage<ContestPrint>> getContestPrint(@RequestParam("cid") Long cid,
                                                             @RequestParam(value = "currentPage",required = false) Integer currentPage,
                                                             @RequestParam(value = "limit", required = false) Integer limit) {
        return contestAdminService.getContestPrint(cid, currentPage, limit);
    }

    /**
     * 比赛管理员确定该次提交的ac情况
     * @param checkACDTO
     * @return
     */
    @PutMapping("/check-contest-ac-info")
    @RequiresAuthentication
    public CommonResult<Void> checkContestACInfo(@RequestBody CheckACDTO checkACDTO) {
        return contestAdminService.checkContestACInfo(checkACDTO);
    }
}
