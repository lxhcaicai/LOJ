package com.github.loj.manager.admin.training;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.training.TrainingCategoryEntityService;
import com.github.loj.pojo.entity.training.TrainingCategory;
import com.github.loj.shiro.AccountProfile;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component
@Slf4j(topic = "loj")
public class AdminTrainingCategoryManager {

    @Resource
    private TrainingCategoryEntityService trainingCategoryEntityService;

    public TrainingCategory addTrainingCategory(TrainingCategory trainingCategory) throws StatusFailException {
        QueryWrapper<TrainingCategory> trainingCategoryQueryWrapper = new QueryWrapper<>();
        trainingCategoryQueryWrapper.eq(trainingCategory.getGid() != null, "gid", trainingCategory.getGid())
                .eq("name",trainingCategory.getName());

        TrainingCategory existedTrainingCategory = trainingCategoryEntityService.getOne(trainingCategoryQueryWrapper, false);

        if (existedTrainingCategory != null) {
            throw new StatusFailException("该分类名称已存在！请勿重复添加！");
        }

        boolean isOk = trainingCategoryEntityService.save(trainingCategory);
        if (!isOk) {
            throw new StatusFailException("添加失败");
        }
        return trainingCategory;
    }

    public void updateTrainingCategory(TrainingCategory trainingCategory) throws StatusFailException {
        boolean isOk = trainingCategoryEntityService.updateById(trainingCategory);
        if (!isOk) {
            throw new StatusFailException("更新失败！");
        }
    }

    public void deleteTrainingCategory(Long cid) throws StatusFailException {
        boolean isOk = trainingCategoryEntityService.removeById(cid);
        if (!isOk) {
            throw new StatusFailException("删除失败！");
        }
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        log.info("[{}],[{}],categoryId:[{}],operatorUid:[{}],operatorUsername:[{}]",
                "Admin_Training", "Delete_Category", cid, userRolesVo.getUid(), userRolesVo.getUsername());
    }
}
