package com.github.loj.manager.admin.contest;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestProblemEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
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
public class AdminContestProblemManager {

    @Autowired
    private ContestProblemEntityService contestProblemEntityService;

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private ProblemEntityService problemEntityService;


    public HashMap<String, Object> getProblemList(Integer limit, Integer currentPage, String keyword,
                                                  Long cid, Integer problemType, String oj) {
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        IPage<Problem> iPage = new Page<>(currentPage, limit);
        // 根据cid在ContestProblem表中查询到对应pid集合
        QueryWrapper<ContestProblem> contestProblemQueryWrapper = new QueryWrapper<>();
        contestProblemQueryWrapper.eq("cid", cid);
        List<Long> pidList = new LinkedList<>();

        List<ContestProblem>  contestProblemList = contestProblemEntityService.list(contestProblemQueryWrapper);
        HashMap<Long, ContestProblem> contestProblemHashMap = new HashMap<>();
        contestProblemList.forEach(contestProblem -> {
            contestProblemHashMap.put(contestProblem.getPid(), contestProblem);
            pidList.add(contestProblem.getPid());
        });

        HashMap<String,Object> contestProblem = new HashMap<>();

        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();

        if(problemType != null) {
            problemQueryWrapper.eq("is_group", false)
                    .and(wrapper -> wrapper.eq("type", problemType)
                            .or().eq("is_remote", true))
                    .ne("auth", 2); // 同时需要与比赛相同类型的题目，权限需要是公开的（隐藏的不可加入！）
            Contest contest = contestEntityService.getById(cid);
            if(contest.getGid() != null) {  //团队比赛不能查看公共题库的隐藏题目
                problemQueryWrapper.ne("auth", 3);
            }
        }

        // 逻辑判断，如果是查询已有的就应该是in，如果是查询不要重复的，使用not in
        if(problemType != null) {
            problemQueryWrapper.notIn(pidList.size()  > 0, "id", pidList);
        } else {
            problemQueryWrapper.in(pidList.size() > 0, "id", pidList);
        }

        // 根据oj筛选过滤
        if(oj != null && !"All".equals(oj)) {
            if(!Constants.RemoteOJ.isRemoteOJ(oj)) {
                problemQueryWrapper.eq("is_remote", false);
            } else {
                problemQueryWrapper.eq("is_remote", true).likeRight("problem_id", oj);
            }
        }

        if(!StringUtils.isEmpty(keyword)) {
            problemQueryWrapper.and(wrapper -> wrapper.like("title", keyword).or()
                    .like("problem_id", keyword).or()
                    .le("author", keyword));
        }

        if(pidList.size() == 0 && problemType == null) {
            problemQueryWrapper = new QueryWrapper<>();
            problemQueryWrapper.eq("id", null);
        }

        IPage<Problem> problemListPage = problemEntityService.page(iPage,problemQueryWrapper);

        if(pidList.size() > 0 && problemType == null) {

            List<Problem> problemList = problemListPage.getRecords();

            List<Problem> sortedProblemList = problemList.stream().sorted(Comparator.comparing(Problem::getId, (a,b) -> {
                ContestProblem x = contestProblemHashMap.get(a);
                ContestProblem y = contestProblemHashMap.get(b);

                if(x == null && y == null) {
                    return 1;
                } else if(x != null && y == null) {
                    return -1;
                } else if(x == null) {
                    return -1;
                } else {
                    return x.getDisplayId().compareTo(y.getDisplayId());
                }
            })).collect(Collectors.toList());
        }
        contestProblem.put("problemList", problemListPage);
        contestProblem.put("contestProblemMap", contestProblemHashMap);

        return contestProblem;
    }

    public Problem getProblem(Long pid) throws StatusForbiddenException, StatusFailException {

        Problem problem = problemEntityService.getById(pid);

        if(problem != null) {// 查询成功
            // 获取当前登录的用户
            AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

            boolean isRoot = SecurityUtils.getSubject().hasRole("root");
            boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
            // 只有超级管理员和题目管理员、题目创建者才能操作
            if(!isRoot && !isProblemAdmin && !userRolesVo.getUsername().equals(problem.getAuthor())) {
                throw new StatusForbiddenException("对不起，你无权限查看题目！");
            }
            return problem;
        } else {
            throw new StatusFailException("查询失败！");
        }
    }
}
