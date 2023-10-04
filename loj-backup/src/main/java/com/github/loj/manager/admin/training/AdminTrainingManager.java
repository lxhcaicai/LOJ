package com.github.loj.manager.admin.training;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.training.MappingTrainingCategoryEntityService;
import com.github.loj.dao.training.TrainingCategoryEntityService;
import com.github.loj.dao.training.TrainingEntityService;
import com.github.loj.dao.training.TrainingRegisterEntityService;
import com.github.loj.pojo.dto.TrainingDTO;
import com.github.loj.pojo.entity.training.MappingTrainingCategory;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.entity.training.TrainingCategory;
import com.github.loj.pojo.entity.training.TrainingRegister;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.TrainingValidator;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.Objects;

@Component
@Slf4j(topic = "loj")
public class AdminTrainingManager {

    @Resource
    private TrainingEntityService trainingEntityService;

    @Resource
    private MappingTrainingCategoryEntityService mappingTrainingCategoryEntityService;

    @Resource
    private TrainingCategoryEntityService trainingCategoryEntityService;

    @Resource
    private TrainingValidator trainingValidator;

    @Resource
    private TrainingRegisterEntityService trainingRegisterEntityService;

    @Resource
    private AdminTrainingRecordManager adminTrainingRecordManager;

    public IPage<Training> getTrainingList(Integer limit, Integer currentPage, String keyword) {
        if (currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if (limit == null || limit < 1) {
            limit = 10;
        }
        IPage<Training> iPage = new Page<>(currentPage, limit);
        QueryWrapper<Training> queryWrapper = new QueryWrapper<>();

        // 过滤密码
        queryWrapper.select(Training.class, info -> !info.getColumn().equals("private_pwd"));
        if (!StringUtils.isEmpty(keyword)) {
            keyword = keyword.trim();
            queryWrapper
                    .like("title", keyword).or()
                    .like("id", keyword).or()
                    .like("`rank`", keyword);
        }

        queryWrapper.eq("is_group",false).orderByAsc("`rank`");

        return trainingEntityService.page(iPage, queryWrapper);
    }

    public TrainingDTO getTraining(Long tid) throws StatusFailException, StatusForbiddenException {
        // 获取本场训练的信息
        Training training = trainingEntityService.getById(tid);
        if (training == null) { // 查询不存在
            throw new StatusFailException("查询失败：该训练不存在,请检查参数tid是否准确！");
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        // 是否为超级管理员
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        // 只有超级管理员和训练拥有者才能操作
        if (!isRoot && !userRolesVo.getUsername().equals(training.getAuthor())) {
            throw new StatusForbiddenException("对不起，你无权限操作！");
        }

        TrainingDTO trainingDTO = new TrainingDTO();
        trainingDTO.setTraining(training);

        QueryWrapper<MappingTrainingCategory> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("tid", tid);
        MappingTrainingCategory mappingTrainingCategory = mappingTrainingCategoryEntityService.getOne(queryWrapper,false);
        TrainingCategory trainingCategory = null;
        if (mappingTrainingCategory != null) {
            trainingCategory = trainingCategoryEntityService.getById(mappingTrainingCategory.getCid());
        }
        trainingDTO.setTrainingCategory(trainingCategory);
        return trainingDTO;
    }

    public void deleteTraining(Long tid) throws StatusFailException {
        boolean isOk = trainingEntityService.removeById(tid);
        /*
        Training的id为其他表的外键的表中的对应数据都会被一起删除！
         */
        if (!isOk) {
            throw new StatusFailException("删除失败！");
        }
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        log.info("[{}],[{}],tid:[{}],operatorUid:[{}],operatorUsername:[{}]",
                "Admin_Training", "Delete", tid, userRolesVo.getUid(), userRolesVo.getUsername());
    }

    public void addTraining(TrainingDTO trainingDTO) throws StatusFailException {
        Training training = trainingDTO.getTraining();
        trainingValidator.validateTraining(training);
        trainingEntityService.save(training);
        TrainingCategory trainingCategory = trainingDTO.getTrainingCategory();
        if (trainingCategory.getGid() == null) {
            try {
                trainingCategoryEntityService.save(trainingCategory);
            } catch (Exception ignored) {
                QueryWrapper<TrainingCategory> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("name", trainingCategory.getName());
                trainingCategory = trainingCategoryEntityService.getOne(queryWrapper,false);
            }
        }

        boolean isOk = mappingTrainingCategoryEntityService.save(new MappingTrainingCategory()
                .setTid(training.getId())
                .setCid(trainingCategory.getId()));

        if (!isOk) {
            throw new StatusFailException("添加失败！");
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public void updateTraining(TrainingDTO trainingDTO) throws StatusFailException, StatusForbiddenException {
        Training training = trainingDTO.getTraining();
        trainingValidator.validateTraining(training);

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        // 是否为超级管理员
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        // 只有超级管理员和训练拥有者才能操作
        if (!isRoot && !userRolesVo.getUsername().equals(trainingDTO.getTraining().getAuthor())) {
            throw new StatusForbiddenException("对不起，你无权限操作！");
        }
        Training oldTraining = trainingEntityService.getById(training.getId());
        trainingEntityService.updateById(training);

        // 私有训练 修改密码 需要清空之前注册训练的记录
        if (training.getAuth().equals(Constants.Training.AUTH_PRIVATE.getValue())) {
            if (!Objects.equals(training.getPrivatePwd(), oldTraining.getPrivatePwd())) {
                UpdateWrapper<TrainingRegister> updateWrapper = new UpdateWrapper<>();
                updateWrapper.eq("tid", training.getId());
                trainingRegisterEntityService.remove(updateWrapper);
            }
        }

        TrainingCategory trainingCategory = trainingDTO.getTrainingCategory();
        if (trainingCategory.getId() == null) {
            try {
                trainingCategoryEntityService.save(trainingCategory);
            } catch (Exception ignored) {
                QueryWrapper<TrainingCategory> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("name", trainingCategory.getName());
                trainingCategory = trainingCategoryEntityService.getOne(queryWrapper, false);
            }
        }

        MappingTrainingCategory mappingTrainingCategory = mappingTrainingCategoryEntityService
                .getOne(new QueryWrapper<MappingTrainingCategory>().eq("tid", training.getId()),false);

        if (mappingTrainingCategory == null) {
            mappingTrainingCategoryEntityService.save(new MappingTrainingCategory()
                    .setTid(training.getId()).setCid(trainingCategory.getId()));
            adminTrainingRecordManager.checkSyncRecord(trainingDTO.getTraining());
        } else {
            if (!mappingTrainingCategory.getCid().equals(trainingCategory.getId())) {
                UpdateWrapper<MappingTrainingCategory> updateWrapper = new UpdateWrapper<>();
                updateWrapper.eq("tid", training.getId()).set("cid", trainingCategory.getId());
                boolean isOk = mappingTrainingCategoryEntityService.update(null, updateWrapper);
                if (isOk) {
                    adminTrainingRecordManager.checkSyncRecord(trainingDTO.getTraining());
                } else {
                    throw new StatusFailException("修改失败");
                }
            }
        }
    }

    public void changeTrainingStatus(Long tid, String author, Boolean status) throws StatusForbiddenException, StatusFailException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        // 是否为超级管理员
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        // 只有超级管理员和训练拥有者才能操作
        if (!isRoot && !userRolesVo.getUsername().equals(author)) {
            throw new StatusForbiddenException("对不起，你无权限操作！");
        }

        boolean isOk = trainingEntityService.saveOrUpdate(new Training().setId(tid).setStatus(status));
        if (!isOk) {
            throw new StatusFailException("修改失败");
        }
    }
}
