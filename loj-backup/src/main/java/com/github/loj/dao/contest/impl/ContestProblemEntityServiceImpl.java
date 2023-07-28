package com.github.loj.dao.contest.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestProblemEntityService;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.mapper.ContestProblemMapper;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.pojo.vo.ContestProblemVO;
import com.github.loj.pojo.vo.ProblemFullScreenListVO;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/10 23:42
 */
@Service
public class ContestProblemEntityServiceImpl extends ServiceImpl<ContestProblemMapper, ContestProblem> implements ContestProblemEntityService {

    @Resource
    private ContestProblemMapper contestProblemMapper;

    @Resource
    private UserInfoEntityService userInfoEntityService;

    @Override
    public List<ProblemFullScreenListVO> getContestFullScreenProblemList(Long cid) {
        return contestProblemMapper.getContestFullScreenProblemList(cid);
    }

    @Override
    public List<ContestProblemVO> getContestProblemList(Long cid, Date startTime, Date endTime, Date sealTime, Boolean isAdmin, String contestAuthorUid, List<String> groupRootUidList) {
        // 筛去 比赛管理员和超级管理员的提交
        List<String> superAdminUidList = userInfoEntityService.getSuperAdminUidList();
        superAdminUidList.add(contestAuthorUid);

        if(!CollectionUtils.isEmpty(groupRootUidList)) {
            superAdminUidList.addAll(groupRootUidList);
        }

        return contestProblemMapper.getContestProblemList(cid,startTime,endTime, sealTime, isAdmin, superAdminUidList);
    }
}
