package com.github.loj.validator;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.exception.StatusAccessDeniedException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.training.TrainingRegisterEntityService;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.entity.training.TrainingRegister;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/11 0:31
 */
@Component
public class TrainingValidator {

    @Resource
    private TrainingRegisterEntityService trainingRegisterEntityService;

    @Autowired
    private GroupValidator groupValidator;

    public void validateTrainingAuth(Training training, AccountProfile userRolesVo) throws StatusForbiddenException, StatusAccessDeniedException {

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        if(training.getIsGroup()) {
            if(!groupValidator.isGroupMember(userRolesVo.getUid(),training.getGid()) && !isRoot) {
                throw new StatusForbiddenException("对不起，您并非该团队内的成员，无权操作！");
            }
        }

        if(Constants.Training.AUTH_PRIVATE.getValue().equals(training.getAuth())) {
            if(userRolesVo == null) {
                throw new StatusAccessDeniedException("该训练属于私有题单，请先登录以校验权限！");
            }

            boolean isAuthor = training.getAuthor().equals(userRolesVo.getUsername()); // 是否为该私有训练的创建者

            if(isRoot || isAuthor || (training.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), training.getGid()))) {
                return;
            }
            // 如果三者都不是，需要做注册权限校验
            checkTrainingRegister(training.getId(), userRolesVo.getUid());
        }
    }

    private void checkTrainingRegister(Long tid, String uid) throws StatusAccessDeniedException, StatusForbiddenException {
        QueryWrapper<TrainingRegister> trainingRegisterQueryWrapper = new QueryWrapper<>();
        trainingRegisterQueryWrapper.eq("tid", tid);
        trainingRegisterQueryWrapper.eq("uid", uid);
        TrainingRegister trainingRegister = trainingRegisterEntityService.getOne(trainingRegisterQueryWrapper,false);

        if(trainingRegister == null) {
            throw new StatusAccessDeniedException("该训练属于私有，请先使用专属密码注册！");
        }

        if(!trainingRegister.getStatus()) {
            throw new StatusForbiddenException("错误：你已被禁止参加该训练！");
        }
    }

    public boolean isInTrainingOrAdmin(Training training, AccountProfile userRolesVo) throws StatusAccessDeniedException {
        if(Constants.Training.AUTH_PRIVATE.getValue().equals(training.getAuth())) {
            if(userRolesVo == null ){
                throw new StatusAccessDeniedException("该训练属于私有题单，请先登录以校验权限！");
            }

            boolean isRoot = SecurityUtils.getSubject().hasRole("root"); // 是否为超级管理员
            boolean isAuthor = training.getAuthor().equals(userRolesVo.getUsername()); // 是否为该私有训练的创建者

            if(isRoot
                || isAuthor
                || (training.getIsGroup() && groupValidator.isGroupRoot(userRolesVo.getUid(), training.getGid()))) {
                return  true;
            }

            // 如果三者都不是，需要做注册权限校验
            QueryWrapper<TrainingRegister> trainingRegisterQueryWrapper = new QueryWrapper<>();
            trainingRegisterQueryWrapper.eq("tid", training.getId());
            trainingRegisterQueryWrapper.eq("uid", userRolesVo.getUid());
            TrainingRegister trainingRegister = trainingRegisterEntityService.getOne(trainingRegisterQueryWrapper, false);

            return trainingRegister != null && trainingRegister.getStatus();
        }
        return true;
    }

    public void validateTrainingAuth(Training training) throws StatusForbiddenException, StatusAccessDeniedException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        validateTrainingAuth(training, userRolesVo);
    }
}
