package com.github.loj.manager.group.training;

import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.dao.training.TrainingEntityService;
import com.github.loj.manager.admin.training.AdminTrainingProblemManager;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;

@Component
public class GroupTrainingProblemManager {

    @Autowired
    private TrainingEntityService trainingEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private AdminTrainingProblemManager adminTrainingProblemManager;

    @Autowired
    private GroupEntityService groupEntityService;

    public HashMap<String, Object> getTrainingProblemList(Integer limit, Integer currentPage, String keyword, Boolean queryExisted, Long tid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Training training = trainingEntityService.getById(tid);

        if (training == null) {
            throw new StatusNotFoundException("获取失败，该训练不存在！");
        }

        Long gid = training.getGid();

        Group group = groupEntityService.getById(gid);

        if (group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取失败，该团队不存在或已被封禁！");
        }

        if (!userRolesVo.getUsername().equals(training.getAuthor()) && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        return adminTrainingProblemManager.getProblemList(limit,currentPage,keyword,queryExisted,tid);

    }
}
