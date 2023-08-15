package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.service.group.problem.GroupProblemService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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

}
