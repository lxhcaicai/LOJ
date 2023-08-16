package com.github.loj.manager.admin.training;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.training.TrainingProblemEntityService;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.entity.training.TrainingProblem;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

@Component
@Slf4j(topic = "loj")
public class AdminTrainingProblemManager {

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private TrainingProblemEntityService trainingProblemEntityService;

    public HashMap<String, Object> getProblemList(Integer limit, Integer currentPage, String keyword, Boolean queryExisted, Long tid) {
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }

        IPage<Problem> iPage = new Page<>(currentPage, limit);
        // 根据tid在TrainingProblem表中查询到对应pid集合
        QueryWrapper<TrainingProblem> trainingProblemQueryWrapper = new QueryWrapper<>();
        trainingProblemQueryWrapper.eq("tid",tid).orderByAsc("display_id");
        List<Long> pidList = new LinkedList<>();
        List<TrainingProblem> trainingProblemList = trainingProblemEntityService.list(trainingProblemQueryWrapper);
        HashMap<Long, TrainingProblem> trainingProblemMap = new HashMap<>();
        trainingProblemList.forEach(trainingProblem -> {
            if(!trainingProblemMap.containsKey(trainingProblem.getPid())) {
                trainingProblemMap.put(trainingProblem.getPid(), trainingProblem);
            }
            pidList.add(trainingProblem.getPid());
        });

        HashMap<String,Object> trainingProblem = new HashMap<>();

        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();

        // 逻辑判断，如果是查询已有的就应该是in，如果是查询不要重复的，使用not in
        if(queryExisted) {
            problemQueryWrapper.in(pidList.size() > 0, "id", pidList);
        } else {
            // 权限需要是公开的（隐藏的，比赛中不可加入！）
            problemQueryWrapper.eq("auth", 1).eq("is_group", false);
            problemQueryWrapper.notIn(pidList.size() > 0, "id", pidList);
        }

        if(!StringUtils.isEmpty(keyword)) {
            problemQueryWrapper.and(wrapper -> wrapper.like("title", keyword).or()
                    .like("problem_id", keyword).or()
                    .like("author", keyword));
        }

        if(pidList.size() == 0 && queryExisted) {
            problemQueryWrapper = new QueryWrapper<>();
            problemQueryWrapper.eq("id", null);
        }

        IPage<Problem> problemListPage = problemEntityService.page(iPage, problemQueryWrapper);

        if(queryExisted && pidList.size() > 0) {
            List<Problem> problemListPageRecords = problemListPage.getRecords();
            List<Problem> sortProblemList = problemListPageRecords
                    .stream()
                    .sorted(Comparator.comparingInt(problem -> trainingProblemMap.get(problem.getId()).getRank()))
                    .collect(Collectors.toList());
            problemListPage.setRecords(sortProblemList);
        }

        trainingProblem.put("problemList", problemListPage);
        trainingProblem.put("trainingProblemMap", trainingProblemMap);

        return trainingProblem;
    }
}
