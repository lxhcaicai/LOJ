package com.github.loj.dao.user;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.user.UserRecord;
import com.github.loj.pojo.vo.ACMRankVO;
import com.github.loj.pojo.vo.OIRankVO;
import com.github.loj.pojo.vo.UserHomeVO;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/5 20:31
 */
public interface UserRecordEntityService extends IService<UserRecord> {
    List<ACMRankVO> getRecent7ACRank();

    UserHomeVO getUserHomeInfo(String uid, String username);

    List<Judge> getLastYearUserJudgeList(String uid, String username);

    IPage<OIRankVO> getOIRankList(Page<OIRankVO> page, List<String> uidList);

    IPage<ACMRankVO> getACMRankList(Page<ACMRankVO> page, List<String> uidList);

    IPage<OIRankVO> getGroupRankList(Page<OIRankVO> page, Long gid, List<String> uidList, String rankType, Boolean useCache);
}
