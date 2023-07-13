package com.github.loj.manager.oj;

/**
 * @author lxhcaicai
 * @date 2023/5/13 22:02
 */

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.Validator;
import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.user.*;
import com.github.loj.manager.email.EmailManager;
import com.github.loj.pojo.dto.CheckUsernameOrEmailDTO;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.user.Role;
import com.github.loj.pojo.entity.user.Session;
import com.github.loj.pojo.entity.user.UserAcproblem;
import com.github.loj.pojo.entity.user.UserInfo;
import com.github.loj.pojo.vo.*;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.utils.RedisUtils;
import com.github.loj.validator.CommonValidator;
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

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private CommonValidator commonValidator;

    private EmailManager emailManager;

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

    public void getChangeEmailCode(String email) throws StatusFailException {
        String lockKey = Constants.Email.CHANGE_EMAIL_LOCK + email;
        if(redisUtils.hasKey(lockKey)) {
            throw new StatusFailException("对不起，您的操作频率过快，请在" + redisUtils.getExpire(lockKey) + "秒后再次发送修改邮件！");
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        QueryWrapper<UserInfo> emailUserInfoQueryWrapper = new QueryWrapper<>();
        emailUserInfoQueryWrapper.select("uuid", "email")
                .eq("email", email);
        UserInfo emailUserInfo = userInfoEntityService.getOne(emailUserInfoQueryWrapper,false);

        if(emailUserInfo != null) {
            if(Objects.equals(emailUserInfo.getUuid(), userRolesVo.getUid()))  {
                throw new StatusFailException("新邮箱与当前邮箱一致，请不要重复设置！");
            } else {
                throw new StatusFailException("该邮箱已被他人使用，请重新设置其它邮箱！");
            }
        }

        String numbers = RandomUtil.randomNumbers(6);
        redisUtils.set(Constants.Email.CHANGE_EMAIL_KEY_PREFIX.getValue() + email, numbers, 10 * 60);
        emailManager.sendChangeEmailCode(email,userRolesVo.getUsername(), numbers);
        redisUtils.set(lockKey, 0, 30);
    }

    public UserInfoVO changeUserInfo(UserInfoVO userInfoVO) throws StatusFailException {
        commonValidator.validateContentLength(userInfoVO.getRealname(), "真实姓名", 50);
        commonValidator.validateContentLength(userInfoVO.getNickname(), "昵称", 20);
        commonValidator.validateContentLength(userInfoVO.getSignature(), "个性简介", 65535);
        commonValidator.validateContentLength(userInfoVO.getBlog(), "博客", 255);
        commonValidator.validateContentLength(userInfoVO.getGithub(),"Github", 255);
        commonValidator.validateContentLength(userInfoVO.getSchool(), "学校", 100);
        commonValidator.validateContentLength(userInfoVO.getNumber(), "学号", 200);
        commonValidator.validateContentLength(userInfoVO.getCfUsername(), "Codeforces用户名", 255);

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        UpdateWrapper<UserInfo> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("uuid", userInfoVO.getUid())
                .set("cf_username", userInfoVO.getCfUsername())
                .set("realname", userInfoVO.getRealname())
                .set("nickname", userInfoVO.getSignature())
                .set("blog", userInfoVO.getBlog())
                .set("gender", userInfoVO.getGender())
                .set("github", userInfoVO.getGithub())
                .set("school", userInfoVO.getSchool())
                .set("number", userInfoVO.getNumber());

        boolean isOk = userInfoEntityService.update(updateWrapper);

        if(isOk) {
            UserRolesVO userRoles = userRoleEntityService.getUserRoles(userRolesVo.getUid(), null);
            // 更新session
            BeanUtil.copyProperties(userRoles, userRolesVo);
            UserInfoVO userInfoVo = new UserInfoVO();
            BeanUtil.copyProperties(userRoles, userInfoVo, "roles");
            userInfoVo.setRoleList(userRoles.getRoles().stream().map(Role::getRole).collect(Collectors.toList()));
            return userInfoVo;
        } else {
            throw new StatusFailException("更新个人信息失败！");
        }
    }
}
