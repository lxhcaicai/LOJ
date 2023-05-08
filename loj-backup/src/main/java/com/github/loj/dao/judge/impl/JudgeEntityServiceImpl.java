package com.github.loj.dao.judge.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestRecordEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.mapper.JudgeMapper;
import com.github.loj.mapper.ProblemMapper;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.JudgeVO;
import com.github.loj.utils.Constants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/7 22:14
 */
@Service
@Slf4j(topic = "loj")
public class JudgeEntityServiceImpl extends ServiceImpl<JudgeMapper, Judge> implements JudgeEntityService {

    @Autowired
    private JudgeMapper judgeMapper;

    @Autowired
    ProblemMapper problemMapper;

    @Autowired
    private ContestRecordEntityService contestRecordEntityService;

    @Override
    public void failToUseRedisPublishJudge(Long submitId, Long pid, Boolean isContest) {
        UpdateWrapper<Judge> judgeUpdateWrapper = new UpdateWrapper<>();
        judgeUpdateWrapper.eq("submit_id", submitId)
                .set("error_message", "The something has gone wrong with the data Backup server. Please report this to administrator.")
                .set("status", Constants.Judge.STATUS_SYSTEM_ERROR.getStatus());
        judgeMapper.update(null,judgeUpdateWrapper);
        // 更新contest_record表
        if(isContest) {
            UpdateWrapper<ContestRecord> updateWrapper = new UpdateWrapper<>();
            updateWrapper.eq("submit_id", submitId)
                    .set("first_blood", false)
                    .set("status", Constants.Contest.RECORD_NOT_AC_NOT_PENALTY.getCode());
            contestRecordEntityService.update(updateWrapper);
        }
    }

    @Override
    public IPage<JudgeVO> getCommonJudgeList(Integer limit, Integer currentPage, String searchPid, Integer status, String username, String uid, Boolean completeProblemID, Long gid) {
        Page<JudgeVO> page = new Page<>(currentPage, limit);
        IPage<JudgeVO> commonJudgeList = judgeMapper.getCommonJudgeList(page, searchPid, status, username, uid, completeProblemID, gid);
        List<JudgeVO> records = commonJudgeList.getRecords();

        if(!CollectionUtils.isEmpty(records)) {
            List<Long> pidList = records.stream().map(JudgeVO::getPid).collect(Collectors.toList());
            QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
            problemQueryWrapper.select("id", "title")
                    .in("id", pidList);
            List<Problem> problemList = problemMapper.selectList(problemQueryWrapper);
            HashMap<Long, String> storeMap = new HashMap<>(limit);
            for(JudgeVO judgeVO: records) {
                judgeVO.setTitle(getProblemTitleByPid(judgeVO.getPid(), problemList, storeMap));
            }
        }

        return commonJudgeList;
    }

    private String getProblemTitleByPid(Long pid, List<Problem> problemList, HashMap<Long,String> storeMap) {
        String title = storeMap.get(pid);
        if(title != null) {
            return  title;
        }
        for (Problem problem: problemList) {
            if(problem.getId().equals(pid)) {
                storeMap.put(pid, problem.getTitle());
                return problem.getTitle();
            }
        }
        return "";
    }
}
