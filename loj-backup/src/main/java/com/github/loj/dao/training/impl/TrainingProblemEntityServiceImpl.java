package com.github.loj.dao.training.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.training.TrainingProblemEntityService;
import com.github.loj.mapper.TrainingProblemMapper;
import com.github.loj.pojo.entity.training.TrainingProblem;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 22:30
 */
@Service
public class TrainingProblemEntityServiceImpl extends ServiceImpl<TrainingProblemMapper, TrainingProblem> implements TrainingProblemEntityService {

    @Resource
    private TrainingProblemMapper trainingProblemMapper;

    @Override
    public List<TrainingProblem> getPrivateTrainingProblemListByPid(Long pid, String uid) {
        return trainingProblemMapper.getPrivateTrainingProblemListByPid(pid, uid);
    }

    @Override
    public List<TrainingProblem> getTrainingListAcceptedCountByUid(List<Long> tidList, String uid) {
        return trainingProblemMapper.getTrainingListAcceptedCountByUid(tidList, uid);
    }
}
