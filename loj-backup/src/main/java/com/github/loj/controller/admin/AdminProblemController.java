package com.github.loj.controller.admin;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.problem.ProblemCase;
import com.github.loj.service.problem.AdminProblemService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/amin/problem")
public class AdminProblemController {

    @Autowired
    private AdminProblemService adminProblemService;

    @GetMapping("/get-problem-list")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<IPage<Problem>> getProblemList(@RequestParam(value = "limit", required = false) Integer limit,
                                                       @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                       @RequestParam(value = "keyword", required = false) String keyword,
                                                       @RequestParam(value = "auth", required = false) Integer auth,
                                                       @RequestParam(value = "oj", required = false) String oj) {
        return adminProblemService.getProblemList(limit,currentPage,keyword,auth,oj);
    }

    @GetMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root","admin", "problem_admin"}, logical = Logical.OR)
    public CommonResult<Problem> getProblem(@RequestParam("pid") Long pid) {
        return adminProblemService.getProblem(pid);
    }

    @DeleteMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> deleteProblem(@RequestParam("pid") Long pid) {
        return adminProblemService.deleteProblem(pid);
    }

    @PostMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin","problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> addProblem(@RequestBody ProblemDTO problemDTO) {
        return adminProblemService.addProblem(problemDTO);
    }

    @PutMapping("")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin","problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> updateProblem(@RequestBody ProblemDTO problemDTO) {
        return adminProblemService.updateProblem(problemDTO);
    }

    @GetMapping("/get-problem-cases")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin","problem_admin"}, logical = Logical.OR)
    public CommonResult<List<ProblemCase>> getProblemCases(@RequestParam("pid") Long pid,
                                                           @RequestParam(value = "isUpload", defaultValue = "true") Boolean isUpload) {
        return adminProblemService.getProblemCases(pid,isUpload);
    }

    @PutMapping("/change-problem-auth")
    @RequiresAuthentication
    @RequiresRoles(value = {"root", "admin","problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> changeProblemAuth(@RequestBody Problem problem) {
        return adminProblemService.changeProblemAuth(problem);
    }
}
