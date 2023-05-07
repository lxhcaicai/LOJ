package com.github.loj.dao.contest.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestRecordEntityService;
import com.github.loj.mapper.ContestRecordMapper;
import com.github.loj.pojo.entity.contest.ContestRecord;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/7 23:51
 */
@Service
public class ContestRecordEntityServiceImpl extends ServiceImpl<ContestRecordMapper, ContestRecord> implements ContestRecordEntityService {
}
