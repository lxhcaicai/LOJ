package com.github.loj.controller.admin;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ContestProblemDTO;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.AdminContestVO;
import com.github.loj.pojo.vo.AnnouncementVO;
import com.github.loj.service.admin.contest.AdminContestAnnouncementService;
import com.github.loj.service.admin.contest.AdminContestProblemService;
import com.github.loj.service.admin.contest.AdminContestService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/contest")
public class AdminContestController {

    @Autowired
    private AdminContestService adminContestService;

    @Autowired
    private AdminContestProblemService adminContestProblemService;

    @Autowired
    private AdminContestAnnouncementService adminContestAnnouncementService;

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

    @PutMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical =  Logical.OR)
    @Transactional(rollbackFor = Exception.class)
    public CommonResult<Void> updateContest(@RequestBody AdminContestVO adminContestVO) {
        return adminContestService.updateContest(adminContestVO);
    }

    @GetMapping("/clone")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical =  Logical.OR)
    public CommonResult<Void> cloneContest(@RequestParam("cid") Long cid) {
        return adminContestService.cloneContest(cid);
    }

    @PutMapping("/change-contest-visible")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical =  Logical.OR)
    public CommonResult<Void> changeContestVisible(@RequestParam(value = "cid", required = false) Long cid,
                                                   @RequestParam(value = "uid", required = false) String uid,
                                                   @RequestParam(value = "visible", required = true) Boolean visible) {

        return adminContestService.changeContestVisible(cid,uid, visible);
    }

    /**
     * 以下为比赛的题目的增删改查操作接口
     */
    @GetMapping("/get-problem-list")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical =  Logical.OR)
    @Transactional(rollbackFor = Exception.class)
    public CommonResult<HashMap<String,Object>> getProblemList(@RequestParam(value = "limit", required = false) Integer limit,
                                                               @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                               @RequestParam(value = "keyword", required = false) String keyword,
                                                               @RequestParam(value = "cid", required = true) Long cid,
                                                               @RequestParam(value = "problemType", required = false) Integer problemType,
                                                               @RequestParam(value = "oj", required = false) String oj) {

        return  adminContestProblemService.getProblemList(limit,currentPage, keyword,cid,problemType,oj);
    }

    @GetMapping("/problem")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical =  Logical.OR)
    public CommonResult<Problem> getProblem(@RequestParam("pid") Long pid, HttpServletRequest request) {
        return adminContestProblemService.getProblem(pid);
    }

    @DeleteMapping("/problem")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","problem_admin"}, logical =  Logical.OR)
    @Transactional(rollbackFor = Exception.class)
    public CommonResult<Void> deleteProblem(@RequestParam("pid") Long pid,
                                            @RequestParam(value = "cid", required = false) Long cid) {
        return adminContestProblemService.deleteProblem(pid, cid);
    }

    @PostMapping("/problem")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    @Transactional(rollbackFor = Exception.class)
    public CommonResult<Map<Object,Object>> addProblem(@RequestBody ProblemDTO problemDTO) {
        return adminContestProblemService.addProblem(problemDTO);
    }

    @PutMapping("/problem")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    @Transactional(rollbackFor = Exception.class)
    public CommonResult<Void> updateProblem(@RequestBody ProblemDTO problemDTO) {
        return adminContestProblemService.updateProblem(problemDTO);
    }

    @GetMapping("/contest-problem")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<ContestProblem> getContestProblem(@RequestParam(value = "cid", required = true) Long cid,
                                                          @RequestParam(value = "pid", required = true) Long pid) {
        return adminContestProblemService.getContestProblem(cid,pid);
    }

    @PutMapping("/contest-problem")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<ContestProblem> setContestProblem(@RequestBody ContestProblem contestProblem) {
        return adminContestProblemService.setContestProblem(contestProblem);
    }

    @PostMapping("/contest-problem")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> addProblemFromPublic(@RequestBody ContestProblemDTO contestProblemDTO) {
        return adminContestProblemService.addProblemFromPublic(contestProblemDTO);
    }

    /**
     * 以下处理比赛公告的操作请求
     */
    @GetMapping("/announcement")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<IPage<AnnouncementVO>> getAnnouncementList(@RequestParam(value = "limit", required = false) Integer limit,
                                                                   @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                                   @RequestParam(value = "cid", required = false) Long cid) {
        return adminContestAnnouncementService.getAnnouncementList(limit, currentPage, cid);
    }

    @DeleteMapping("/announcement")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> deleteAnnouncement(@RequestParam("aid") Long aid) {
        return adminContestAnnouncementService.deleteAnnouncement(aid);
    }
}
