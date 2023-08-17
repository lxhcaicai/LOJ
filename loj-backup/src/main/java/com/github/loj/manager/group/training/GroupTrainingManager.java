package com.github.loj.manager.group.training;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.dao.group.GroupTrainingEntityService;
import com.github.loj.dao.training.*;
import com.github.loj.manager.admin.training.AdminTrainingRecordManager;
import com.github.loj.pojo.dto.TrainingDTO;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.entity.training.*;
import com.github.loj.pojo.vo.TrainingVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.GroupValidator;
import com.github.loj.validator.TrainingValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Objects;

@Component
public class GroupTrainingManager {

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private GroupTrainingEntityService groupTrainingEntityService;

    @Autowired
    private TrainingEntityService trainingEntityService;

    @Autowired
    private TrainingValidator trainingValidator;

    @Autowired
    private TrainingRegisterEntityService trainingRegisterEntityService;

    @Autowired
    private TrainingCategoryEntityService trainingCategoryEntityService;

    @Autowired
    private MappingTrainingCategoryEntityService mappingTrainingCategoryEntityService;

    @Autowired
    private AdminTrainingRecordManager adminTrainingRecordManager;

    @Autowired
    private GroupValidator groupValidator;

    public IPage<TrainingVO> getTrainingList(Integer limit, Integer currentPage, Long gid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupMember(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return groupTrainingEntityService.getTrainingList(limit,currentPage, gid);
    }

    public IPage<Training> getAdminTrainingList(Integer limit, Integer currentPage, Long gid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupMember(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return groupTrainingEntityService.getAdminTrainingList(limit,currentPage, gid);
    }

    public TrainingDTO getTraining(Long tid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Training training = trainingEntityService.getById(tid);

        if(training == null) {
            throw new StatusNotFoundException("该训练不存在！");
        }

        Long gid = training.getGid();

        if(gid == null) {
            throw new StatusForbiddenException("获取失败，不可访问非团队内的训练！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取训练失败，该团队不存在或已被封禁！");
        }

        if(!userRolesVo.getUsername().equals(training.getAuthor())
                && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        TrainingDTO trainingDTO = new TrainingDTO();
        trainingDTO.setTraining(training);

        QueryWrapper<MappingTrainingCategory> mappingTrainingCategoryQueryWrapper = new QueryWrapper<>();
        mappingTrainingCategoryQueryWrapper.eq("tid", tid);

        MappingTrainingCategory mappingTrainingCategory = mappingTrainingCategoryEntityService.getOne(mappingTrainingCategoryQueryWrapper);
        TrainingCategory trainingCategory = null;

        if(mappingTrainingCategory != null) {
            trainingCategory = trainingCategoryEntityService.getById(mappingTrainingCategory.getCid());
        }
        trainingDTO.setTrainingCategory(trainingCategory);
        return trainingDTO;
    }

    @Transactional(rollbackFor = Exception.class)
    public void addTraining(TrainingDTO trainingDto) throws StatusFailException, StatusForbiddenException, StatusNotFoundException {

        trainingValidator.validateTraining(trainingDto.getTraining());

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long gid = trainingDto.getTraining().getGid();

        if(gid == null) {
            throw new StatusForbiddenException("添加失败，训练所属的团队ID不可为空！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("添加训练失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupAdmin(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        trainingDto.getTraining().setIsGroup(true);

        Training training = trainingDto.getTraining();
        trainingEntityService.save(training);
        TrainingCategory trainingCategory = trainingDto.getTrainingCategory();

        if(trainingCategory.getGid() != null && !Objects.equals(trainingCategory.getGid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(trainingCategory.getGid() == null) {
            try {
                trainingCategory.setGid(gid);
                trainingCategoryEntityService.save(trainingCategory);
            } catch (Exception ignored) {
                QueryWrapper<TrainingCategory> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("name", trainingCategory.getName());
                trainingCategory = trainingCategoryEntityService.getOne(queryWrapper, false);
            }
        }

        boolean isOk = mappingTrainingCategoryEntityService.save(new MappingTrainingCategory()
                .setTid(training.getId())
                .setCid(trainingCategory.getId()));

        if(!isOk) {
            throw new StatusFailException("添加失败！");
        }
    }

    public void updateTraining(TrainingDTO trainingDto) throws StatusFailException, StatusForbiddenException, StatusNotFoundException {

        trainingValidator.validateTraining(trainingDto.getTraining());

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long tid = trainingDto.getTraining().getId();

        if(tid == null) {
            throw new StatusForbiddenException("更新失败，训练ID不能为空！");
        }

        Training training = trainingEntityService.getById(tid);

        if(training == null) {
            throw new StatusNotFoundException("该训练不存在！");
        }

        Long gid = training.getGid();

        if(gid == null) {
            throw new StatusForbiddenException("添加失败，训练所属的团队ID不可为空！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("添加训练失败，该团队不存在或已被封禁！");
        }

        if(!userRolesVo.getUsername().equals(training.getAuthor()) && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        trainingDto.getTraining().setIsGroup(training.getIsGroup());

        trainingEntityService.updateById(trainingDto.getTraining());

        if(trainingDto.getTraining().getAuth().equals(Constants.Training.AUTH_PRIVATE.getValue())) {
            if(!Objects.equals(training.getPrivatePwd(), trainingDto.getTraining().getPrivatePwd())) {
                UpdateWrapper<TrainingRegister> updateWrapper = new UpdateWrapper<>();
                updateWrapper.eq("tid", tid);
                trainingRegisterEntityService.remove(updateWrapper);
            }
        }

        TrainingCategory trainingCategory = trainingDto.getTrainingCategory();

        if(trainingCategory.getGid() != null && trainingCategory.getGid().longValue() != gid) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(trainingCategory.getGid() != null) {
            try {
                trainingCategory.setGid(gid);
                trainingCategoryEntityService.save(trainingCategory);
            } catch (Exception ignored) {
                QueryWrapper<TrainingCategory> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("name", trainingCategory.getName());
                trainingCategory = trainingCategoryEntityService.getOne(queryWrapper, false);
            }
        }

        MappingTrainingCategory mappingTrainingCategory = mappingTrainingCategoryEntityService
                .getOne(new QueryWrapper<MappingTrainingCategory>().eq("tid", training.getId()), false);

        if(mappingTrainingCategory == null) {
            mappingTrainingCategoryEntityService.save(new MappingTrainingCategory()
                    .setTid(training.getId())
                    .setCid(trainingCategory.getId()));

            adminTrainingRecordManager.checkSyncRecord(trainingDto.getTraining());
        } else {
            if(!mappingTrainingCategory.getCid().equals(trainingCategory.getId())) {
                UpdateWrapper<MappingTrainingCategory> updateWrapper = new UpdateWrapper<>();
                updateWrapper.eq("tid", training.getId()).set("cid", trainingCategory.getId());
                boolean isOk = mappingTrainingCategoryEntityService.update(null, updateWrapper);
                if(isOk) {
                    adminTrainingRecordManager.checkSyncRecord(trainingDto.getTraining());
                } else {
                    throw new StatusFailException("修改失败");
                }
            }
        }
    }

    public void deleteTraining(Long tid) throws StatusForbiddenException, StatusNotFoundException, StatusFailException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Training training = trainingEntityService.getById(tid);

        if(training == null) {
            throw new StatusNotFoundException("该训练不存在！");
        }

        Long gid = training.getGid();

        if(gid == null) {
            throw new StatusForbiddenException("删除失败，不可操作非团队内的训练！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("删除训练失败，该团队不存在或已被封禁！");
        }

        if(!userRolesVo.getUsername().equals(training.getAuthor()) && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        boolean isOk = trainingEntityService.removeById(tid);
        if(!isOk) {
            throw new StatusFailException("删除失败！");
        }
    }

    public void changeTrainingStatus(Long tid, Boolean status) throws StatusNotFoundException, StatusForbiddenException, StatusFailException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Training training = trainingEntityService.getById(tid);

        if(training == null) {
            throw new StatusNotFoundException("该训练不存在！");
        }

        Long gid = training.getGid();

        if(gid == null) {
            throw new StatusForbiddenException("修改失败，不可操作非团队内的训练！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("修改训练失败，该团队不存在或已被封禁！");
        }

        if(!userRolesVo.getUsername().equals(training.getAuthor()) && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        UpdateWrapper<Training> trainingUpdateWrapper = new UpdateWrapper<>();
        trainingUpdateWrapper.eq("id",tid).set("status", status);

        boolean isOk = trainingEntityService.update(trainingUpdateWrapper);
        if(!isOk) {
            throw new StatusFailException("修改失败");
        }
    }
}
