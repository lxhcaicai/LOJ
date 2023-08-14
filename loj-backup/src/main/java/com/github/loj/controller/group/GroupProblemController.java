package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
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

}
