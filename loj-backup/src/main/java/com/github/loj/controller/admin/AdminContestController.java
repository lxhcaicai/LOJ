package com.github.loj.controller.admin;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.AdminContestVO;
import com.github.loj.service.admin.contest.AdminContestService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin/contest")
public class AdminContestController {

    @Autowired
    private AdminContestService adminContestService;

    @GetMapping("/get-contest-list")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical =  Logical.OR)
    public CommonResult<IPage<Contest>> getContestList(@RequestParam(value = "limit", required = false) Integer limit,
                                                       @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                       @RequestParam(value = "keyword", required = false) String keyword) {

        return adminContestService.getContestList(limit,currentPage,keyword);
    }

    @GetMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical =  Logical.OR)
    public CommonResult<AdminContestVO> getContest(@RequestParam("cid") Long cid) {
        return adminContestService.getContest(cid);
    }

    /**
     * 只有超级管理员能删除比赛
     * @param cid
     * @return
     */
    @DeleteMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = "root")
    public CommonResult<Void> deleteContest(@RequestParam("cid") Long cid) {
        return adminContestService.deleteContest(cid);
    }

    @PostMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical =  Logical.OR)
    public CommonResult<Void> addContest(@RequestBody AdminContestVO adminContestVO) {

        return adminContestService.addContest(adminContestVO);
    }
}
