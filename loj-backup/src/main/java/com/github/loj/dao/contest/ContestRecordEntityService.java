package com.github.loj.dao.contest;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.pojo.vo.ContestRecordVO;

import java.util.Date;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 23:50
 */
public interface ContestRecordEntityService extends IService<ContestRecord> {

    List<ContestRecordVO> getACMContestRecord(String contestCreatorUid, Long cid, List<Integer> externalCidList, Date startTime);

    IPage<ContestRecord> getACInfo(Integer currentPage,
                                   Integer limit,
                                   Integer status,
                                   Long cid,
                                   String contestCreatorId);

    List<ContestRecordVO> getOIContestRecord(Contest contest, List<Integer> externalCidList, Boolean isOpenSealRank);
}
