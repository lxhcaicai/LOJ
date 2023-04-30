package com.github.loj.dao.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.ContestRecordEntityService;
import com.github.loj.mapper.ContestRecordMapper;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.util.Constants;
import org.springframework.context.ApplicationContext;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/30 8:48
 */
public class ContestRecordEntityServiceImpl extends ServiceImpl<ContestRecordMapper, ContestRecord> implements ContestRecordEntityService {

    @Resource
    private ApplicationContext applicationContext;

    private static List<Integer> penaltyStatus = Arrays.asList(
            Constants.Judge.STATUS_PRESENTATION_ERROR.getStatus(),
            Constants.Judge.STATUS_WRONG_ANSWER.getStatus(),
            Constants.Judge.STATUS_TIME_LIMIT_EXCEEDED.getStatus(),
            Constants.Judge.STATUS_MEMORY_LIMIT_EXCEEDED.getStatus(),
            Constants.Judge.STATUS_RUNTIME_ERROR.getStatus());

    @Retryable(value = Exception.class,
            maxAttempts = 5,backoff = @Backoff(delay = 500, multiplier = 1.4))
    public void updateContestRecordWithRetry(Integer score, Integer status, Long submitId, Integer useTime) {

        UpdateWrapper<ContestRecord> updateWrapper = new UpdateWrapper<>();
        // 如果是AC
        if(status.intValue() == Constants.Judge.STATUS_ACCEPTED.getStatus()) {
            updateWrapper.set("status", Constants.Contest.RECORD_AC.getCode());
            // 部分通过
        } else if(status.intValue() == Constants.Judge.STATUS_PARTIAL_ACCEPTED.getStatus()) {
            updateWrapper.set("status", Constants.Contest.RECORD_NOT_AC_NOT_PENALTY.getCode());
            // 需要被罚时的状态
        } else if(penaltyStatus.contains(status)) {
            updateWrapper.set("status", Constants.Contest.RECORD_NOT_AC_PENALTY.getCode());
        } else {
            updateWrapper.set("status", Constants.Contest.RECORD_NOT_AC_NOT_PENALTY.getCode());
        }

        if(score != null) {
            updateWrapper.set("score", score);
        }

        updateWrapper.set("use_time", useTime);

        updateWrapper.eq("submit_id", submitId);
        boolean isOk = update(null, updateWrapper);
        if(!isOk) {
            String log = String.format("[contest_record] update contest record failed, submit_id:%s, status:%s, score:%s, useTime:%s",
                    submitId, status, score, useTime);
            throw  new RuntimeException(log);
        }

    }

    @Override
    public void updateContestRecord(Integer score, Integer status, Long submitId, Integer useTime) {
        ContestRecordEntityServiceImpl service = applicationContext.getBean(ContestRecordEntityServiceImpl.class);
        try {
            service.updateContestRecordWithRetry(score, status, submitId, useTime);
        } catch (Exception e) {
            log.error("", e);
        }
    }

}
