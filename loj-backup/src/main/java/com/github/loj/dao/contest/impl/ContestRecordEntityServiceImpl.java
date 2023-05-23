package com.github.loj.dao.contest.impl;

import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestRecordEntityService;
import com.github.loj.mapper.ContestRecordMapper;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.pojo.vo.ContestRecordVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 23:51
 */
@Service
public class ContestRecordEntityServiceImpl extends ServiceImpl<ContestRecordMapper, ContestRecord> implements ContestRecordEntityService {

    @Autowired
    private ContestRecordMapper contestRecordMapper;

    @Override
    public List<ContestRecordVO> getACMContestRecord(String contestCreatorUid, Long cid, List<Integer> externalCidList, Date startTime) {
        if(CollectionUtils.isEmpty(externalCidList)) {
            return contestRecordMapper.getACMContestRecord(contestCreatorUid, cid, null, null);
        } else {
            long time = DateUtil.between(startTime, new Date(), DateUnit.SECOND);
            return contestRecordMapper.getACMContestRecord(contestCreatorUid, cid, externalCidList, time);
        }
    }
}
