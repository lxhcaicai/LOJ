package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ProblemDTO;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.problem.ProblemCase;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.service.group.problem.GroupProblemService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiresAuthentication
@RequestMapping("/api/group")
public class GroupProblemController {

    @Autowired
    private GroupProblemService groupProblemService;

    @GetMapping("/get-problem-list")
    public CommonResult<IPage<ProblemVO>>  getProblemList(@RequestParam(value = "limit", required = false) Integer limit,
                                                          @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                          @RequestParam(value = "gid", required = true) Long gid) {
        return groupProblemService.getProblemList(limit,currentPage,gid);
    }

    @GetMapping("/get-admin-problem-list")
    public CommonResult<IPage<Problem>>  getAdminProblemList(@RequestParam(value = "limit", required = false) Integer limit,
                                                             @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                             @RequestParam(value = "gid", required = true) Long gid) {
        return groupProblemService.getAdminProblemList(limit,currentPage,gid);
    }

    @GetMapping("/problem")
    public CommonResult<Problem> getProblem(@RequestParam("pid") Long pid) {
        return groupProblemService.getProblem(pid);
    }

    @PostMapping("/problem")
    public CommonResult<Problem> addProblem(@RequestBody ProblemDTO problemDTO) {
        return groupProblemService.addProblem(problemDTO);
    }

    @PutMapping("/problem")
    public CommonResult<Problem> updateProblem(@RequestBody ProblemDTO problemDTO) {
        return groupProblemService.updateProblem(problemDTO);
    }

    @DeleteMapping("/problem")
    public CommonResult<Void> deleteProblem(@RequestParam(value = "pid", required = true) Long pid) {
        return groupProblemService.deleteProblem(pid);
    }

    @GetMapping("/get-problem-cases")
    public CommonResult<List<ProblemCase>> getProblemCases(@RequestParam("pid") Long pid,
                                                           @RequestParam(value = "isUpload", defaultValue = "true") Boolean isUpload) {
        return groupProblemService.getProblemCases(pid, isUpload);
    }

    @GetMapping("/get-all-problem-tags")
    public CommonResult<List<Tag>> getAllProblemTagList(@RequestParam("gid") Long gid) {
        return groupProblemService.getAllProblemTagList(gid);
    }

    @PutMapping("/change-problem-auth")
    public CommonResult<Void> changeProblemAuth(@RequestParam(value = "pid", required = true) Long pid,
                                                @RequestParam(value = "auth", required = true) Integer auth) {
        return groupProblemService.changeProblemAuth(pid, auth);
    }

    @PutMapping("/apply-public")
    public CommonResult<Void> applyPublic(@RequestParam(value = "pid", required = true) Long pid,
                                          @RequestParam(value = "isApplied", required = true) Boolean isApplied){
        return groupProblemService.applyPublic(pid,isApplied);
    }
}
