package com.github.loj.manager.oj;

/**
 * @author lxhcaicai
 * @date 2023/5/13 22:02
 */

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.Validator;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.user.*;
import com.github.loj.manager.email.EmailManager;
import com.github.loj.pojo.dto.ChangeEmailDTO;
import com.github.loj.pojo.dto.ChangePasswordDTO;
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

import java.text.SimpleDateFormat;
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

    public ChangeAccountVO changePassword(ChangePasswordDTO changePasswordDTO) throws StatusFailException, StatusSystemErrorException {
        String oldPassword = changePasswordDTO.getOldPassword();
        String newPassword = changePasswordDTO.getNewPassword();

        // 数据可用性判断
        if(StringUtils.isEmpty(oldPassword) || StringUtils.isEmpty(newPassword)) {
            throw new StatusFailException("错误：原始密码或新密码不能为空！");
        }
        if(newPassword.length() < 6 || newPassword.length() > 20) {
            throw new StatusFailException("新密码长度应该为6~20位！");
        }
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 如果已经被锁定半小时，则不能修改
        String lockKey = Constants.Account.CODE_CHANGE_PASSWORD_LOCK + userRolesVo.getUid();
        // 统计失败的key
        String countKey = Constants.Account.CODE_CHANGE_PASSWORD_FAIL + userRolesVo.getUid();

        ChangeAccountVO resp = new ChangeAccountVO();
        if(redisUtils.hasKey(lockKey)) {
            long expire = redisUtils.getExpire(lockKey);
            Date now = new Date();
            long minute = expire / 60;
            long second = expire % 60;
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            resp.setCode(403);
            Date afterDate = new Date(now.getTime() + expire * 1000);
            String msg = "由于您多次修改密码失败，修改密码功能已锁定，请在" + minute + "分" + second + "秒后(" + formatter.format(afterDate) + ")再进行尝试！";
            resp.setMsg(msg);
            return resp;
        }
        QueryWrapper<UserInfo> userInfoQueryWrapper = new QueryWrapper<>();
        userInfoQueryWrapper.select("uuid", "password")
                .eq("uuid", userRolesVo.getUid());
        UserInfo userInfo = userInfoEntityService.getOne(userInfoQueryWrapper,false);
        // 与当前登录用户的密码进行比较判断
        if(userInfo.getPassword().equals(SecureUtil.md5(newPassword))) {
            UpdateWrapper<UserInfo> updateWrapper = new UpdateWrapper<>();
            updateWrapper.set("password", SecureUtil.md5(newPassword))
                    .eq("uuid", userRolesVo.getUid());
            boolean isOk = userInfoEntityService.update(updateWrapper);
            if(isOk) {
                resp.setCode(200);
                resp.setMsg("修改密码成功！您将于5秒钟后退出进行重新登录操作！");
                // 清空记录
                redisUtils.del(countKey);
                return resp;
            } else {
                throw new StatusSystemErrorException("系统错误：修改密码失败！");
            }
        } else {
            // 如果不同，则进行记录，当失败次数达到5次，半个小时后才可重试
            Integer count = (Integer) redisUtils.get(countKey);
            if(count == null) {
                redisUtils.set(countKey, 1, 60 * 30);
                count = 0;
            } else if(count < 5) {
                redisUtils.incr(countKey, 1);
            }
            count ++;
            if(count == 5) {
                redisUtils.del(countKey); // 清空统计
                redisUtils.set(lockKey, "lock", 60 * 30); // 设置锁定更改
            }
            resp.setCode(400);
            resp.setMsg("原始密码错误！您已累计修改密码失败" + count + "次...");
            return resp;
         }
    }

    public ChangeAccountVO changeEmail(ChangeEmailDTO changeEmailDTO) throws StatusFailException, StatusSystemErrorException {

        String password = changeEmailDTO.getPassword();
        String newEmail = changeEmailDTO.getNewEmail();
        String code = changeEmailDTO.getCode();

        // 数据可用性判断
        if(StringUtils.isEmpty(password) || StringUtils.isEmpty(newEmail) || StringUtils.isEmpty(code)) {
            throw new StatusFailException("错误：密码、新邮箱或验证码不能为空！");
        }

        if(!Validator.isEmail(newEmail)) {
            throw new StatusFailException("邮箱格式错误！");
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        // 如果已经被锁定半小时不能修改
        String lockKey = Constants.Account.CODE_CHANGE_EMAIL_LOCK + userRolesVo.getUid();
        // 统计失败的key
        String countKey = Constants.Account.CODE_CHANGE_EMAIL_FAIL + userRolesVo.getUid();

        ChangeAccountVO resp = new ChangeAccountVO();
        if(redisUtils.hasKey(lockKey)) {
            long expire = redisUtils.getExpire(lockKey);
            Date now = new Date();
            long minute = expire / 60;
            long second = expire % 60;
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            resp.setCode(403);
            Date afterDate = new Date(now.getTime() + expire * 1000);
            String msg = "由于您多次修改邮箱失败，修改邮箱功能已锁定，请在" + minute + "分" + second + "秒后(" + formatter.format(afterDate) + ")再进行尝试！";
            resp.setMsg(msg);
            return resp;
        }

        QueryWrapper<UserInfo> emailUserInfoQueryWrapper = new QueryWrapper<>();
        emailUserInfoQueryWrapper.select("uuid", "email")
                .eq("email", changeEmailDTO.getNewEmail());
        UserInfo emailUserInfo = userInfoEntityService.getOne(emailUserInfoQueryWrapper, false);

        if(emailUserInfo != null) {
            if(Objects.equals(emailUserInfo.getUuid(), userRolesVo.getUid())) {
                throw new StatusFailException("新邮箱与当前邮箱一致，请不要重复设置！");
            } else {
                throw new StatusFailException("该邮箱已被他人使用，请重新设置其它邮箱！");
            }
        }
        QueryWrapper<UserInfo> userInfoQueryWrapper = new QueryWrapper<>();
        userInfoQueryWrapper.select("uuid", "password")
                .eq("uuid", userRolesVo.getUid());
        UserInfo userInfo = userInfoEntityService.getOne(userInfoQueryWrapper, false);

        String cacheCodeKey = Constants.Email.CHANGE_EMAIL_KEY_PREFIX.getValue() + newEmail;
        String cacheCode = (String) redisUtils.get(cacheCodeKey);
        if(cacheCode == null) {
            throw new StatusFailException("修改邮箱验证码不存在或已过期，请重新发送！");
        }

        if(!Objects.equals(cacheCode, code)) {
            Integer count = (Integer) redisUtils.get(countKey);
            if(count == null) {
                redisUtils.set(countKey, 1, 60 * 30); // 三十分钟不尝试，该限制会自动清空消失
                count = 0;
            } else if(count < 5) {
                redisUtils.incr(countKey, 1);
            }
            count ++;
            if(count == 5) {
                redisUtils.del(countKey); // 清空统计
                redisUtils.set(lockKey, "lock", 60 * 30); // 设置锁定更改
            }

            resp.setCode(400);
            resp.setMsg("验证码错误！您已累计修改邮箱失败" + count + "次...");
            return resp;
        }

        // 与当前登录用户的密码进行比较判断
        if(userInfo.getPassword().equals(SecureUtil.md5(password))) {
            UpdateWrapper<UserInfo> updateWrapper = new UpdateWrapper<>();
            updateWrapper.set("email", newEmail)
                    .eq("uuid", userRolesVo.getUid());
            boolean isOk = userInfoEntityService.update(updateWrapper);
            if(!isOk) {
                UserRolesVO userRoles = userRoleEntityService.getUserRoles(userRolesVo.getUid(), null);
                UserInfoVO userInfoVO = new UserInfoVO();

                BeanUtil.copyProperties(userRoles, userInfoVO, "roles");
                userInfoVO.setRoleList(userRoles
                        .getRoles()
                        .stream()
                        .map(Role::getRole)
                        .collect(Collectors.toList()));
                resp.setCode(200);
                resp.setMsg("修改邮箱成功！");
                resp.setUserInfo(userInfoVO);
                // 清空记录
                redisUtils.del(countKey, cacheCodeKey);
                return resp;
            } else {
                throw new StatusSystemErrorException("系统错误：修改邮箱失败！");
            }
        } else { // 如果不同，则进行记录，当失败次数达到5次，半个小时后才可重试
            Integer count = (Integer) redisUtils.get(countKey);
            if(count == null) {
                redisUtils.set(countKey, 1, 60 * 30);
                count = 0;
            } else if(count < 5) {
                redisUtils.incr(countKey, 1);
            }
            count ++;
            if(count == 5) {
                redisUtils.del(countKey); // 清空统计
                redisUtils.set(lockKey, "lock", 60 * 30); // 设置锁定更改
            }
            resp.setCode(400);
            resp.setMsg("密码错误！您已累计修改邮箱失败" + count + "次...");
            return resp;
        }
    }
}
