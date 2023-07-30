package com.github.loj.dao.contest.impl;

import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestRecordEntityService;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.mapper.ContestRecordMapper;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.pojo.vo.ContestRecordVO;
import com.github.loj.utils.Constants;
import com.github.loj.utils.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.*;

/**
 * @author lxhcaicai
 * @date 2023/5/7 23:51
 */
@Service
public class ContestRecordEntityServiceImpl extends ServiceImpl<ContestRecordMapper, ContestRecord> implements ContestRecordEntityService {

    @Autowired
    private ContestRecordMapper contestRecordMapper;

    @Autowired
    private UserInfoEntityService userInfoEntityService;

    @Autowired
    private RedisUtils redisUtils;

    @Override
    public List<ContestRecordVO> getACMContestRecord(String contestCreatorUid, Long cid, List<Integer> externalCidList, Date startTime) {
        if(CollectionUtils.isEmpty(externalCidList)) {
            return contestRecordMapper.getACMContestRecord(contestCreatorUid, cid, null, null);
        } else {
            long time = DateUtil.between(startTime, new Date(), DateUnit.SECOND);
            return contestRecordMapper.getACMContestRecord(contestCreatorUid, cid, externalCidList, time);
        }
    }

    @Override
    public IPage<ContestRecord> getACInfo(Integer currentPage, Integer limit, Integer status, Long cid, String contestCreatorId) {
        List<ContestRecord> acInfo = contestRecordMapper.getACInfo(status,cid);

        HashMap<Long,String> pidMapUidAndPid = new HashMap<>(12);
        HashMap<String, Long> UidAndPidMapTime = new HashMap<>(12);

        List<String> superAdminUidList = userInfoEntityService.getSuperAdminUidList();

        List<ContestRecord> userACInfo = new LinkedList<>();

        for(ContestRecord contestRecord: acInfo) {
            if(contestRecord.getUid().equals(contestCreatorId)
                    || superAdminUidList.contains(contestRecord.getUid())) {// 超级管理员和比赛创建者的提交跳过
                continue;
            }

            contestRecord.setFirstBlood(false);
            String uidAndPid = pidMapUidAndPid.get(contestRecord.getPid());
            if(uidAndPid == null) {
                pidMapUidAndPid.put(contestRecord.getPid(), contestRecord.getUid() + contestRecord.getPid());
                UidAndPidMapTime.put(contestRecord.getUid() + contestRecord.getPid(), contestRecord.getTime());
            } else {
                Long firstTime = UidAndPidMapTime.get(uidAndPid);
                Long tmpTime = contestRecord.getTime();
                if(tmpTime < firstTime) {
                    pidMapUidAndPid.put(contestRecord.getPid(), contestRecord.getUid() + contestRecord.getPid());
                    UidAndPidMapTime.put(contestRecord.getUid() + contestRecord.getPid(), tmpTime);
                }
            }
            userACInfo.add(contestRecord);
        }

        List<ContestRecord> pageList = new ArrayList<>();

        int count = userACInfo.size();

        //计算当前页第一条数据的下标
        int currId = currentPage > 1 ? (currentPage - 1) * limit:0;
        for(int i = 0; i < limit && i < count - currId; i ++) {
            ContestRecord contestRecord = userACInfo.get(currId + 1);
            if(pidMapUidAndPid.get(contestRecord.getPid()).equals(contestRecord.getUid() + contestRecord.getPid())) {
                contestRecord.setFirstBlood(true);
            }
            pageList.add(contestRecord);
        }
        Page<ContestRecord> page = new Page<>(currentPage, limit);
        page.setSize(limit);
        page.setCurrent(currentPage);
        page.setTotal(count);
        page.setRecords(pageList);

        return page;
    }

    @Override
    public List<ContestRecordVO> getOIContestRecord(Contest contest, List<Integer> externalCidList, Boolean isOpenSealRank) {
        String oiRankScoreType = contest.getOiRankScoreType();
        Long cid = contest.getId();
        String contestCreatorUid = contest.getUid();

        if(!isOpenSealRank) {
            // 封榜解除 获取最新数据
            // 获取每个用户每道题最近一次提交
            Long endTime = contest.getDuration();
            if(Objects.equals(Constants.Contest.OI_RANK_RECENT_SCORE.getName(),oiRankScoreType)) {
                return contestRecordMapper.getOIContestRecordByRecentSubmission(cid,
                        externalCidList,
                        contestCreatorUid,
                        false,
                        null,
                        endTime);
            } else {
                return contestRecordMapper.getOIContestRecordByHighestSubmission(cid,
                        externalCidList,
                        contestCreatorUid,
                        false,
                        null,
                        endTime);
            }
        } else {
            String key = Constants.Contest.OI_CONTEST_RANK_CACHE.getName() +"_" + oiRankScoreType + "_" + cid;
            List<ContestRecordVO> oiContestRecordList = (List<ContestRecordVO>) redisUtils.get(key);
            if(oiContestRecordList == null) {
                Long sealTime = DateUtil.between(contest.getStartTime(), contest.getSealRankTime(), DateUnit.SECOND);
                if(sealTime > 0) {
                    sealTime --;
                }
                if(Objects.equals(Constants.Contest.OI_RANK_RECENT_SCORE.getName(), oiRankScoreType)) {
                    oiContestRecordList = contestRecordMapper.getOIContestRecordByRecentSubmission(cid,
                            externalCidList,
                            contestCreatorUid,
                            true,
                            sealTime,
                            null);
                } else {
                    oiContestRecordList = contestRecordMapper.getOIContestRecordByHighestSubmission(cid,
                            externalCidList,
                            contestCreatorUid,
                            true,
                            sealTime,
                            null);
                }
                redisUtils.set(key, oiContestRecordList, 2 * 3600);
            }
            return oiContestRecordList;
        }
    }
}
