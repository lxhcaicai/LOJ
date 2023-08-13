package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.AdminContestVO;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.service.group.contest.GroupContestService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiresAuthentication
@RequestMapping("/api/group")
public class GroupContestController {

    @Autowired
    private GroupContestService groupContestService;

    @GetMapping("/get-contest-list")
    public CommonResult<IPage<ContestVO>> getContestList(@RequestParam(value = "limit", required = false) Integer limit,
                                                         @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                         @RequestParam(value = "gid", required = true) Long gid) {
        return groupContestService.getContestList(limit,currentPage, gid);
    }

    @GetMapping("/get-admin-contest-list")
    public CommonResult<IPage<Contest>> getAdminContestList(@RequestParam(value = "limit", required = false) Integer limit,
                                                            @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                            @RequestParam(value = "gid", required = true) Long gid) {
        return groupContestService.getAdminContestList(limit,currentPage, gid);
    }

    @GetMapping("/contest")
    public CommonResult<AdminContestVO> getContest(@RequestParam("cid") Long cid) {
        return groupContestService.getContest(cid);
    }

    @PostMapping("/contest")
    public CommonResult<Void> addContest(@RequestBody AdminContestVO adminContestVO) {
        return groupContestService.addContest(adminContestVO);
    }

    @PutMapping("/contest")
    public CommonResult<Void> updateContest(@RequestBody AdminContestVO adminContestVO) {
        return groupContestService.updateContest(adminContestVO);
    }
}
