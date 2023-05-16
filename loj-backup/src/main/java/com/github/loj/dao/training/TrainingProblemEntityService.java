package com.github.loj.dao.training;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.training.TrainingProblem;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 22:28
 */
public interface TrainingProblemEntityService extends IService<TrainingProblem> {
    public List<TrainingProblem> getPrivateTrainingProblemListByPid(Long pid, String uid);

    public List<TrainingProblem> getTrainingListAcceptedCountByUid(List<Long> tidList, String uid);
}
