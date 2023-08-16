package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.vo.TrainingVO;
import com.github.loj.service.group.training.GroupTrainingService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiresAuthentication
@RequestMapping("/api/group")
public class GroupTrainingController {

    @Autowired
    private GroupTrainingService groupTrainingService;

    @GetMapping("/get-training-list")
    public CommonResult<IPage<TrainingVO>> getTrainingList(@RequestParam(value = "limit", required = false) Integer limit,
                                                           @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                           @RequestParam(value = "gid", required = true) Long gid) {
        return groupTrainingService.getTrainingList(limit, currentPage, gid);
    }

    @GetMapping("/get-admin-training-list")
    public CommonResult<IPage<Training>> getAdminTrainingList(@RequestParam(value = "limit", required = false) Integer limit,
                                                              @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                              @RequestParam(value = "gid", required = true) Long gid) {
        return groupTrainingService.getAdminTrainingList(limit, currentPage, gid);
    }
}
