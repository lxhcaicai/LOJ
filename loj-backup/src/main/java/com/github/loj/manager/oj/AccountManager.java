package com.github.loj.manager.oj;

/**
 * @author lxhcaicai
 * @date 2023/5/13 22:02
 */

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.Validator;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.user.*;
import com.github.loj.pojo.dto.CheckUsernameOrEmailDTO;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.user.Role;
import com.github.loj.pojo.entity.user.Session;
import com.github.loj.pojo.entity.user.UserAcproblem;
import com.github.loj.pojo.entity.user.UserInfo;
import com.github.loj.pojo.vo.*;
import com.github.loj.shiro.AccountProfile;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Component
public class AccountManager {

    @Autowired
    private UserRoleEntityService userRoleEntityService;

    @Autowired
    private UserInfoEntityService userInfoEntityService;

    @Autowired
    private UserRecordEntityService userRecordEntityService;

    @Autowired
    private UserAcproblemEntityService userAcproblemEntityService;

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private SessionEntityService sessionEntityService;

    public CheckUsernameOrEmailVO checkUsernameOrEmail(CheckUsernameOrEmailDTO checkUsernameOrEmailDTO) {

        String email = checkUsernameOrEmailDTO.getEmail();
        String username = checkUsernameOrEmailDTO.getUsername();

        boolean rightEmail = false;
        boolean rightUsername = false;

        if(!StringUtils.isEmpty(email)) {
            email = email.trim();
            boolean isEmail = Validator.isEmail(email);
            if(!isEmail) {
                rightEmail = false;
            } else {
                QueryWrapper<UserInfo> wrapper = new QueryWrapper<UserInfo>().eq("email", email);
                UserInfo user = userInfoEntityService.getOne(wrapper, false);
                if(user != null) {
                    rightEmail = true;
                } else {
                    rightEmail = false;
                }
            }
        }

        if(!StringUtils.isEmpty(username)) {
            username = username.trim();
            QueryWrapper<UserInfo> wrapper = new QueryWrapper<UserInfo>().eq("username", username);
            UserInfo userInfo = userInfoEntityService.getOne(wrapper, false);
            if(userInfo != null) {
                rightUsername = true;
            } else {
                rightUsername = false;
            }
        }

        CheckUsernameOrEmailVO checkUsernameOrEmailVO = new CheckUsernameOrEmailVO()
                .setEmail(rightEmail)
                .setUsername(rightUsername);
        return checkUsernameOrEmailVO;
    }

    public UserAuthInfoVO getUserAuthInfo() {
        // 获取当前登录的用户
        AccountProfile userRolesVO = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        //获取该用户角色所有的权限
        List<Role> roles = userRoleEntityService.getRolesByUid(userRolesVO.getUid());
        UserAuthInfoVO authInfoVO = new UserAuthInfoVO();
        authInfoVO.setRoles(roles.stream().map(Role::getRole).collect(Collectors.toList()));
        return authInfoVO;
    }

    public UserCalendarHeatmapVO getUserCalendarHeatmap(String uid, String username) throws StatusFailException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        if(StringUtils.isEmpty(uid) && StringUtils.isEmpty(username)) {
            if(userRolesVo != null) {
                uid = userRolesVo.getUid();
            } else {
                throw new StatusFailException("请求参数错误：uid和username不能都为空！");
            }
        }

        UserCalendarHeatmapVO userCalendarHeatmapVO = new UserCalendarHeatmapVO();
        userCalendarHeatmapVO.setEndDate(DateUtil.format(new Date(), "yyyy-MM-dd"));
        List<Judge> lastYearUserJudgeList = userRecordEntityService.getLastYearUserJudgeList(uid, username);
        if(CollectionUtils.isEmpty(lastYearUserJudgeList)) {
            userCalendarHeatmapVO.setDataList(new ArrayList<>());
            return userCalendarHeatmapVO;
        }
        HashMap<String,Integer> tmpRecordMap = new HashMap<>();
        for(Judge judge: lastYearUserJudgeList) {
            Date submitTime = judge.getSubmitTime();
            String dateStr = DateUtil.format(submitTime, "yyyy-MM-dd");
            tmpRecordMap.merge(dateStr, 1, Integer::sum);
        }
        List<HashMap<String,Object>> dataList = new ArrayList<>();
        for(Map.Entry<String,Integer> record: tmpRecordMap.entrySet()) {
            HashMap<String,Object> tmp = new HashMap<>(2);
            tmp.put("date", record.getKey());
            tmp.put("count", record.getValue());
            dataList.add(tmp);
        }
        userCalendarHeatmapVO.setDataList(dataList);
        return userCalendarHeatmapVO;
    }

    public UserHomeVO getUserHomeInfo(String uid, String username) throws StatusFailException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        if(StringUtils.isEmpty(uid) && StringUtils.isEmpty(username)) {
            if(userRolesVo != null) {
                uid = userRolesVo.getUid();
            } else {
                throw new StatusFailException("请求参数错误：uid和username不能都为空！");
            }
        }

        UserHomeVO userHomeInfo = userRecordEntityService.getUserHomeInfo(uid,username);
        if(userHomeInfo == null) {
            throw new StatusFailException("用户不存在");
        }
        QueryWrapper<UserAcproblem> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("uid", userHomeInfo.getUid())
                .select("distinct pid", "submit_id")
                .orderByAsc("submit_id");

        List<UserAcproblem> acProblemList = userAcproblemEntityService.list(queryWrapper);
        List<Long> pidList = acProblemList.stream().map(UserAcproblem::getPid).collect(Collectors.toList());

        List<String> disPlayIdList = new LinkedList<>();

        if(pidList.size() > 0) {
            QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
            problemQueryWrapper.select("id", "problem_id", "difficulty");
            problemQueryWrapper.in("id", pidList);
            List<Problem> problems = problemEntityService.list(problemQueryWrapper);
            Map<Integer,List<UserHomeProblemVO>> map = problems.stream()
                    .map(this::convertProblemVo)
                    .collect(Collectors.groupingBy(UserHomeProblemVO::getDifficulty));
            userHomeInfo.setSolvedGroupByDifficulty(map);
            disPlayIdList = problems.stream().map(Problem::getProblemId).collect(Collectors.toList());

        }
        userHomeInfo.setSolvedList(disPlayIdList);
        QueryWrapper<Session> sessionQueryWrapper = new QueryWrapper<>();
        sessionQueryWrapper.eq("uid", userHomeInfo.getUid())
                .orderByDesc("gmt_create")
                .last("limit 1");

        Session recentSession = sessionEntityService.getOne(sessionQueryWrapper,false);
        if(recentSession != null) {
            userHomeInfo.setRecentLoginTime(recentSession.getGmtCreate());
        }
        return userHomeInfo;
    }

    private UserHomeProblemVO convertProblemVo(Problem problem) {
        return UserHomeProblemVO.builder()
                .problemId(problem.getProblemId())
                .id(problem.getId())
                .difficulty(problem.getDifficulty())
                .build();
    }
}
