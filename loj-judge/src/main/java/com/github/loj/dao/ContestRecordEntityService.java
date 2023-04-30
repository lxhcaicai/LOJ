package com.github.loj.dao;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.contest.ContestRecord;

/**
 * @author lxhcaicai
 * @date 2023/4/30 8:24
 */
public interface ContestRecordEntityService extends IService<ContestRecord> {
    void updateContestRecord(Integer score, Integer status, Long submitId, Integer useTime);
}
