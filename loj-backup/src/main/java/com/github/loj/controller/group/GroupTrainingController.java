package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.TrainingDTO;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.entity.training.TrainingProblem;
import com.github.loj.pojo.vo.TrainingVO;
import com.github.loj.service.group.training.GroupTrainingProblemService;
import com.github.loj.service.group.training.GroupTrainingService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@RestController
@RequiresAuthentication
@RequestMapping("/api/group")
public class GroupTrainingController {

    @Autowired
    private GroupTrainingService groupTrainingService;

    @Autowired
    private GroupTrainingProblemService groupTrainingProblemService;

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

    @GetMapping("/training")
    public CommonResult<TrainingDTO> getTraining(@RequestParam("tid") Long tid) {
        return groupTrainingService.getTraining(tid);
    }

    @PostMapping("/training")
    public CommonResult<Void> addTraining(@RequestBody TrainingDTO trainingDto) {
        return groupTrainingService.addTraining(trainingDto);
    }

    @PutMapping("/training")
    public CommonResult<Void> updateTraining(@RequestBody TrainingDTO trainingDto) {
        return groupTrainingService.updateTraining(trainingDto);
    }

    @DeleteMapping("/training")
    public CommonResult<Void> deleteTraining(@RequestParam(value = "tid", required = true) Long tid) {
        return groupTrainingService.deleteTraining(tid);
    }

    @PutMapping("/change-training-staus")
    public CommonResult<Void> changeTrainingStatus(@RequestParam(value = "tid", required = true) Long tid,
                                                   @RequestParam(value = "status", required = true) Boolean status) {
        return groupTrainingService.changeTrainingStatus(tid,status);
    }

    @GetMapping("/get-training-problem-list")
    public CommonResult<HashMap<String, Object>> getTrainingProblemList(@RequestParam(value = "limit", required = false) Integer limit,
                                                                        @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                                        @RequestParam(value = "keyword", required = false) String keyword,
                                                                        @RequestParam(value = "queryExisted", required = false, defaultValue = "true") Boolean queryExisted,
                                                                        @RequestParam(value = "tid", required = true) Long tid) {
        return groupTrainingProblemService.getTrainingProblemList(limit, currentPage, keyword, queryExisted, tid);
    }

    @PutMapping("/training-problem")
    public CommonResult<Void> updateTrainingProblem(@RequestBody TrainingProblem trainingProblem) {
        return groupTrainingProblemService.updateTrainingProblem(trainingProblem);
    }

    @DeleteMapping("/training-problem")
    public CommonResult<Void> deleteTrainingProblem(@RequestParam(value = "pid", required = true) Long pid,
                                                    @RequestParam(value = "tid", required = true) Long tid) {
        return groupTrainingProblemService.deleteTrainingProblem(pid,tid);
    }
}
