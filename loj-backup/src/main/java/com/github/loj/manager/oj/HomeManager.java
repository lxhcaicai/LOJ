package com.github.loj.manager.oj;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.user.UserRecordEntityService;
import com.github.loj.pojo.entity.common.File;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ACMRankVO;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.pojo.vo.RecentUpdatedProblemVO;
import com.github.loj.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/14 22:51
 */
@Component
public class HomeManager {

    @Autowired
    FileEntityService fileEntityService;

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private UserRecordEntityService userRecordEntityService;

    @Autowired
    private ProblemEntityService problemEntityService;

    /**
     * 获取主页轮播图
     * @return
     */
    public List<HashMap<String,Object>> getHomeCarousel() {
        List<File> fileList = fileEntityService.queryCarouselFileList();
        List<HashMap<String,Object>> apiList = fileList.stream().map(f -> {
            HashMap<String,Object> param = new HashMap<>(2);
            param.put("id", f.getId());
            param.put("url", Constants.File.IMG_API.getPath() + f.getName());
            return param;
        }).collect(Collectors.toList());
        return apiList;
    }

    /**
     * 获取最近14天的比赛
     * @return
     */
    public List<ContestVO> getRecentContest() {
        return contestEntityService.getWithinNext14DaysContests();
    }


    /**
     * 获取最近7天用户做题榜单
     * @return
     */
    public List<ACMRankVO> getRecentSevenACRank() {
        return userRecordEntityService.getRecent7ACRank();
    }

    public List<RecentUpdatedProblemVO> getRecentUpdatedProblemList() {

        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
        problemQueryWrapper.select("id", "problem_id", "title", "type", "gmt_modified", "gmt_create")
                .eq("auth", 1)
                .eq("is_group", false)
                .orderByDesc("gmt_create" )
                .last("limit 10");
        List<Problem> problemList = problemEntityService.list(problemQueryWrapper);
        if( !CollectionUtils.isEmpty(problemList)) {
            return problemList.stream()
                    .map(this::convertUpdatedProblemVO)
                    .collect(Collectors.toList());
        }
        return new ArrayList<>();
    }

    private RecentUpdatedProblemVO convertUpdatedProblemVO(Problem problem) {
        return RecentUpdatedProblemVO.builder()
                .problemId(problem.getProblemId())
                .id(problem.getId())
                .title(problem.getTitle())
                .gmtCreate(problem.getGmtCreate())
                .gmtModified(problem.getGmtModified())
                .type(problem.getType())
                .build();
    }
}
