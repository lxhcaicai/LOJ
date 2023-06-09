package com.github.loj.dao.training.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.training.TrainingProblemEntityService;
import com.github.loj.mapper.TrainingProblemMapper;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.training.TrainingProblem;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

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

    @Resource
    private JudgeEntityService judgeEntityService;

    @Override
    public List<TrainingProblem> getPrivateTrainingProblemListByPid(Long pid, String uid) {
        return trainingProblemMapper.getPrivateTrainingProblemListByPid(pid, uid);
    }

    @Override
    public List<TrainingProblem> getTrainingListAcceptedCountByUid(List<Long> tidList, String uid) {
        return trainingProblemMapper.getTrainingListAcceptedCountByUid(tidList, uid);
    }

    @Override
    public List<Long> getTrainingProblemIdList(Long tid) {
        return trainingProblemMapper.getTrainingProblemCount(tid);
    }

    @Override
    public Integer getUserTrainingACProblemCount(String uid, Long gid, List<Long> pidList) {
        if(CollectionUtils.isEmpty(pidList)) {
            return  0;
        }
        QueryWrapper<Judge> judgeQueryWrapper = new QueryWrapper<>();
        judgeQueryWrapper.select("DISTINCT pid")
                .in("pid", pidList)
                .eq("cid", 0)
                .eq("uid", uid)
                .eq("status", 0);

        if(gid == null) {
            judgeQueryWrapper.isNull("gid");
        } else {
            judgeQueryWrapper.eq("gid", gid);
        }

        return judgeEntityService.count(judgeQueryWrapper);
    }
}
