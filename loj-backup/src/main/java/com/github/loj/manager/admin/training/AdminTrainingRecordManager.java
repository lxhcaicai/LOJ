package com.github.loj.manager.admin.training;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.training.TrainingProblemEntityService;
import com.github.loj.dao.training.TrainingRecordEntityService;
import com.github.loj.dao.training.TrainingRegisterEntityService;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.entity.training.TrainingProblem;
import com.github.loj.pojo.entity.training.TrainingRecord;
import com.github.loj.utils.Constants;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Component
public class AdminTrainingRecordManager {

    @Resource
    private TrainingProblemEntityService trainingProblemEntityService;

    @Resource
    private JudgeEntityService judgeEntityService;

    @Resource
    private TrainingRecordEntityService trainingRecordEntityService;

    @Resource
    private TrainingRegisterEntityService trainingRegisterEntityService;

    @Async
    public void syncUserSubmissionToRecordByTid(Long tid,String uid) {
        QueryWrapper<TrainingProblem> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("tid",tid);
        List<TrainingProblem> trainingProblemList = trainingProblemEntityService.list(queryWrapper);
        List<Long> pidList = new ArrayList<>();
        HashMap<Long,Long> pidMapTPid = new HashMap<>();
        for(TrainingProblem trainingProblem: trainingProblemList) {
            pidList.add(trainingProblem.getPid());
            pidMapTPid.put(trainingProblem.getPid(),trainingProblem.getId());
        }
        if(!CollectionUtils.isEmpty(pidList)) {
            QueryWrapper<Judge> judgeQueryWrapper = new QueryWrapper<>();
            judgeQueryWrapper.in("pid", pidList)
                    .eq("cid", 0)
                    .eq("status", Constants.Judge.STATUS_ACCEPTED.getStatus())
                    .eq("uid",uid);
            List<Judge> judgeList = judgeEntityService.list(judgeQueryWrapper);
            saveBatchNewRecordByJudgeList(judgeList, tid, null, pidMapTPid);
        }
    }

    private void saveBatchNewRecordByJudgeList(List<Judge> judgeList,Long tid, Long tpId, HashMap<Long,Long> pidMapTPid) {
        if(!CollectionUtils.isEmpty(judgeList)) {
            List<TrainingRecord> trainingRecordList = new ArrayList<>();
            for(Judge judge: judgeList) {
                TrainingRecord trainingRecord = new TrainingRecord()
                        .setPid(judge.getPid())
                        .setSubmitId(judge.getSubmitId())
                        .setTid(tid)
                        .setUid(judge.getUid());
                if(pidMapTPid != null) {
                    trainingRecord.setTpid(pidMapTPid.get(judge.getPid()));
                }
                if(tpId != null) {
                    trainingRecord.setTpid(tpId);
                }
                trainingRecordList.add(trainingRecord);
            }
            trainingRecordEntityService.saveBatch(trainingRecordList);
        }
    }

    @Async
    public void checkSyncRecord(Training training) {
        if(!Constants.Training.AUTH_PRIVATE.getValue().equals(training.getAuth())) {
            return;
        }
        QueryWrapper<TrainingRecord> trainingRecordQueryWrapper = new QueryWrapper<>();
        trainingRecordQueryWrapper.eq("tid", training.getId());
        int count = trainingRecordEntityService.count(trainingRecordQueryWrapper);
        if(count <= 0) {
            syncAllUserProblemRecord(training.getId());
        }
    }

    private void  syncAllUserProblemRecord(Long tid) {
        QueryWrapper<TrainingProblem> trainingProblemQueryWrapper = new QueryWrapper<>();
        trainingProblemQueryWrapper.eq("tid", tid);
        List<TrainingProblem> trainingProblemList = trainingProblemEntityService.list(trainingProblemQueryWrapper);
        if(trainingProblemList.size() == 0) {
            return;
        }
        List<Long> pidList = new ArrayList<>();
        HashMap<Long,Long> pidMapTPid = new HashMap<>();
        for(TrainingProblem trainingProblem: trainingProblemList) {
            pidList.add(trainingProblem.getPid());
            pidMapTPid.put(trainingProblem.getPid(), trainingProblem.getId());
        }

        List<String> uidList = trainingRegisterEntityService.getAlreadyRegisterUidList(tid);
        if(uidList.size() == 0) {
            return;
        }
        QueryWrapper<Judge> judgeQueryWrapper = new QueryWrapper<>();
        judgeQueryWrapper.in("pid", pidList)
                .eq("cid", 0)
                .eq("status", Constants.Judge.STATUS_ACCEPTED.getStatus()) // 只同步ac的提交
                .in("uid", uidList);
        List<Judge> judgeList = judgeEntityService.list(judgeQueryWrapper);
        saveBatchNewRecordByJudgeList(judgeList, tid, null, pidMapTPid);
    }
}
