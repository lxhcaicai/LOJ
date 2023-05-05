package com.github.loj.dao.user.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.user.UserRecordEntityService;
import com.github.loj.mapper.JudgeMapper;
import com.github.loj.mapper.UserRecordMapper;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.user.UserRecord;
import com.github.loj.pojo.vo.ACMRankVO;
import com.github.loj.pojo.vo.OIRankVO;
import com.github.loj.pojo.vo.UserHomeVO;
import com.github.loj.utils.Constants;
import com.github.loj.utils.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/5 20:58
 */
@Service
public class UserRecordEntityServiceImpl extends ServiceImpl<UserRecordMapper, UserRecord> implements UserRecordEntityService {

    @Autowired
    private UserRecordMapper userRecordMapper;

    @Autowired
    private JudgeMapper judgeMapper;

    @Autowired
    private RedisUtils redisUtils;

    // 排行榜缓存时间 10s
    private static final long cacheRankSecond = 10;

    @Override
    public List<ACMRankVO> getRecent7ACRank() {
        return userRecordMapper.getRecent7ACRank();
    }

    @Override
    public UserHomeVO getUserHomeInfo(String uid, String username) {
        return userRecordMapper.getUserHomeInfo(uid, username);
    }

    @Override
    public List<Judge> getLastYearUserJudgeList(String uid, String username) {
        return judgeMapper.getLastYearUserJudgeList(uid, username);
    }

    @Override
    public IPage<OIRankVO> getOIRankList(Page<OIRankVO> page, List<String> uidList) {
        return userRecordMapper.getOIRankList(page, uidList);
    }

    @Override
    public IPage<ACMRankVO> getACMRankList(Page<ACMRankVO> page, List<String> uidList) {
        return userRecordMapper.getACMRankList(page, uidList);
    }

    @Override
    public IPage<OIRankVO> getGroupRankList(Page<OIRankVO> page, Long gid, List<String> uidList, String rankType, Boolean useCache) {
        if(useCache) {
            IPage<OIRankVO> data = null;
            String key = Constants.Account.GROUP_RANK_CACHE.getCode() + "_" + gid +"_" + rankType + "_" + page.getCurrent() + "_" + page.getSize();
            data = (IPage<OIRankVO>) redisUtils.get(key);
            if(data == null) {
                data = userRecordMapper.getGroupRankList(page, gid, uidList, rankType);
                redisUtils.set(key, data, cacheRankSecond);
            }
            return data;
        } else {
            return userRecordMapper.getGroupRankList(page, gid, uidList, rankType);
        }
    }
}
