package com.github.loj.dao.group.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.group.GroupTrainingEntityService;
import com.github.loj.dao.training.TrainingProblemEntityService;
import com.github.loj.mapper.GroupTrainingMapper;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.entity.training.TrainingProblem;
import com.github.loj.pojo.vo.TrainingVO;
import com.github.loj.shiro.AccountProfile;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class GroupTrainingEntityServiceImpl extends ServiceImpl<GroupTrainingMapper, Training> implements GroupTrainingEntityService {

    @Autowired
    private GroupTrainingMapper groupTrainingMapper;

    @Autowired
    private TrainingProblemEntityService trainingProblemEntityService;

    @Override
    public IPage<TrainingVO> getTrainingList(Integer limit, Integer currentPage, Long gid) {
        IPage<TrainingVO> iPage = new Page<>(currentPage, limit);

        List<TrainingVO> trainingList = groupTrainingMapper.getTrainingList(iPage, gid);

        // 当前用户有登录，且训练列表不为空，则查询用户对于每个训练的做题进度
        if(trainingList.size() > 0) {
            AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

            List<Long> tidList = trainingList.stream().map(TrainingVO::getId).collect(Collectors.toList());
            List<TrainingProblem> trainingProblemList = trainingProblemEntityService.getGroupTrainingListAcceptedCountByUid(tidList, gid,userRolesVo.getUid());

            HashMap<Long, Integer> tidMapCount = new HashMap<>(trainingList.size());
            for(TrainingProblem trainingProblem: trainingProblemList) {
                int count = tidMapCount.getOrDefault(trainingProblem.getTid(), 0);
                count ++;
                tidMapCount.put(trainingProblem.getTid(), count);
            }

            for(TrainingVO trainingVO: trainingList) {
                Integer count = tidMapCount.getOrDefault(trainingVO.getId(), 0);
                trainingVO.setAcCount(count);
            }
        }

        return iPage.setRecords(trainingList);
    }

    @Override
    public IPage<Training> getAdminTrainingList(Integer limit, Integer currentPage, Long gid) {
        IPage<Training> iPage = new Page<>(currentPage, limit);

        List<Training> trainingList = groupTrainingMapper.getAdminTrainingList(iPage, gid);

        return iPage.setRecords(trainingList);
    }
}
