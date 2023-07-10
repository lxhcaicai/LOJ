package com.github.loj.manager.oj;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.lang.Validator;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.loj.common.exception.StatusAccessDeniedException;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.config.NacosSwitchConfig;
import com.github.loj.config.WebConfig;
import com.github.loj.dao.user.SessionEntityService;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.dao.user.UserRecordEntityService;
import com.github.loj.dao.user.UserRoleEntityService;
import com.github.loj.manager.email.EmailManager;
import com.github.loj.manager.msg.NoticeManager;
import com.github.loj.pojo.bo.EmailRuleBO;
import com.github.loj.pojo.dto.ApplyResetPasswordDTO;
import com.github.loj.pojo.dto.LoginDTO;
import com.github.loj.pojo.dto.RegisterDTO;
import com.github.loj.pojo.dto.ResetPasswordDTO;
import com.github.loj.pojo.entity.user.*;
import com.github.loj.pojo.vo.RegisterCodeVO;
import com.github.loj.pojo.vo.UserInfoVO;
import com.github.loj.pojo.vo.UserRolesVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.utils.IpUtils;
import com.github.loj.utils.JwtUtils;
import com.github.loj.utils.RedisUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/12 23:24
 */
@Component
public class PassportManager {

    @Resource
    private RedisUtils redisUtils;

    @Resource
    private JwtUtils jwtUtils;

    @Resource
    private UserRoleEntityService userRoleEntityService;

    @Resource
    private NacosSwitchConfig nacosSwitchConfig;

    @Resource
    private EmailRuleBO emailRuleBO;

    @Resource
    private SessionEntityService sessionEntityService;

    @Resource
    private UserRecordEntityService userRecordEntityService;

    @Resource
    private NoticeManager noticeManager;

    @Resource
    private EmailManager emailManager;

    @Resource
    private UserInfoEntityService userInfoEntityService;

    public UserInfoVO login(LoginDTO loginDTO, HttpServletResponse response, HttpServletRequest request) throws StatusFailException {

        loginDTO.setPassword(loginDTO.getPassword().trim());
        loginDTO.setUsername(loginDTO.getUsername().trim());

        if(StringUtils.isEmpty(loginDTO.getUsername()) || StringUtils.isEmpty(loginDTO.getPassword())) {
            throw new StatusFailException("用户名或密码不能为空！");
        }

        if(loginDTO.getPassword().length() < 6 || loginDTO.getPassword().length() > 20) {
            throw new StatusFailException("密码长度应该为6~20位！");
        }

        if(loginDTO.getUsername().length() > 20) {
            throw new StatusFailException("用户名长度不能超过20位!");
        }

        String userIpAddr = IpUtils.getUserIpAddr(request);
        String key = Constants.Account.TRY_LOGIN_NUM.getCode() + loginDTO.getUsername() + "_" + userIpAddr;
        Integer tryLoginCount = (Integer) redisUtils.get(key);

        if(tryLoginCount != null && tryLoginCount >= 20) {
            throw new StatusFailException("对不起！登录失败次数过多！您的账号有风险，半个小时内暂时无法登录！");
        }

        UserRolesVO userRolesVO = userRoleEntityService.getUserRoles(null, loginDTO.getUsername());

        if(userRolesVO == null) {
            throw new StatusFailException("用户名或密码错误！请注意大小写！");
        }

        if(!userRolesVO.getPassword().equals(SecureUtil.md5(loginDTO.getPassword()))) {
            if(tryLoginCount == null) {
                redisUtils.set(key, 1, 60 * 30);
            } else {
                redisUtils.set(key, tryLoginCount + 1, 60 * 30);
            }
            throw new StatusFailException("用户名或密码错误！请注意大小写！");
        }

        if(userRolesVO.getStatus() != 0) {
            throw new StatusFailException("该账户已被封禁，请联系管理员进行处理！");
        }

        String jwt = jwtUtils.generateToken(userRolesVO.getUid());
        response.setHeader("Authorization", jwt);
        response.setHeader("Access-Control-Expose-Headers", "Authorization");

        // 会话记录
        sessionEntityService.save(new Session()
                .setUid(userRolesVO.getUid())
                .setIp(IpUtils.getUserIpAddr(request))
                .setUserAgent(request.getHeader("User-Agent")));

        // 登录成功，清除锁定限制
        if(tryLoginCount != null) {
            redisUtils.del(key);
        }

        // 异步检查是否异地登录
        sessionEntityService.checkRemoteLogin(userRolesVO.getUid());

        UserInfoVO userInfoVO = new UserInfoVO();
        BeanUtil.copyProperties(userRolesVO, userInfoVO, "roles");
        userInfoVO.setRoleList(userRolesVO.getRoles()
                .stream()
                .map(Role::getRole)
                .collect(Collectors.toList()));
        return userInfoVO;
    }

    public void logout() {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        jwtUtils.cleanToken(userRolesVo.getUid());
        SecurityUtils.getSubject().logout();
    }

    public void applyResetPassword(ApplyResetPasswordDTO applyResetPasswordDTO) throws StatusFailException {

        String captcha = applyResetPasswordDTO.getCaptcha();
        String captchaKey = applyResetPasswordDTO.getCaptchaKey();
        String email = applyResetPasswordDTO.getEmail();

        if(StrUtil.isBlank(captcha) || StrUtil.isBlank(email) || StrUtil.isBlank(captchaKey)) {
            throw new StatusFailException("邮箱或验证码不能为空");
        }

        if(!emailManager.isOk()) {
            throw new StatusFailException("对不起！本站邮箱系统未配置，暂不支持重置密码！");
        }

        String lockKey = Constants.Email.RESET_EMAIL_LOCK +email;
        if(redisUtils.hasKey(lockKey)) {
            throw new StatusFailException("对不起，您的操作频率过快，请在" + redisUtils.getExpire(lockKey) + "秒后再次发送重置邮件");
        }

        // 获取redis中的验证码
        String redisCode = (String) redisUtils.get(captchaKey);
        if(!Objects.equals(redisCode, captcha.trim().toLowerCase())) {
            //throw new StatusFailException("验证码不正确");
        }

        QueryWrapper<UserInfo> userInfoQueryWrapper = new QueryWrapper<>();
        userInfoQueryWrapper.eq("email", email.trim());
        UserInfo userInfo = userInfoEntityService.getOne(userInfoQueryWrapper, false);
        if(userInfo == null) {
            throw new StatusFailException("对不起，该邮箱无该用户，请重新检查！");
        }

        String code = IdUtil.simpleUUID().substring(0, 21);
        redisUtils.set(Constants.Email.RESET_PASSWORD_KEY_PREFIX.getValue() + userInfo.getUsername(), code, 10 * 60); //默认链接有效10分钟
        // 发送邮件
        emailManager.sendResetPassword(userInfo.getUsername(), code, email.trim());
        redisUtils.set(lockKey, 0, 90);
    }

    public RegisterCodeVO getRegisterCode(String email) throws StatusAccessDeniedException, StatusFailException, StatusForbiddenException {

        WebConfig webConfig = nacosSwitchConfig.getWebConfig();
        if(!webConfig.getRegister()) { // 需要判断一下网站是否开启注册
            throw new StatusAccessDeniedException("对不起！本站暂未开启注册功能！");
        }
        if(! emailManager.isOk()) {
            throw new StatusAccessDeniedException("对不起！本站邮箱系统未配置，暂不支持注册！");
        }

        email = email.trim();

        boolean isEmail = Validator.isEmail(email);
        if(!isEmail) {
            throw new StatusFailException("对不起！您的邮箱格式不正确！");
        }

        boolean isBlackEmail = emailRuleBO.getBlackList().stream().anyMatch(email::endsWith);
        if(isBlackEmail) {
            throw new StatusForbiddenException("对不起！您的邮箱无法注册本网站！");
        }

        String lockKey = Constants.Email.REGISTER_EMAIL_LOCK + email;
        if(redisUtils.hasKey(lockKey)) {
            throw new StatusFailException("对不起，您的操作频率过快，请在" + redisUtils.getExpire(lockKey) + "秒后再次发送注册邮件！");
        }

        QueryWrapper<UserInfo> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("email", email);
        UserInfo userInfo = userInfoEntityService.getOne(queryWrapper, false);
        if(userInfo != null) {
            throw new StatusFailException("对不起！该邮箱已被注册，请更换新的邮箱！");
        }

        String numbers = RandomUtil.randomNumbers(6);  // 随机生成6位数字的组合
        redisUtils.set(Constants.Email.REGISTER_KEY_PREFIX.getValue() + email, numbers, 10 * 60); //默认验证码有效10分钟
        emailManager.sendRegisterCode(email, numbers);
        redisUtils.set(lockKey, 0, 60);

        RegisterCodeVO registerCodeVO = new RegisterCodeVO();
        registerCodeVO.setEmail(email)
                .setExpire(5*60);

        return registerCodeVO;
    }

    @Transactional(rollbackFor = Exception.class)
    public void register(RegisterDTO registerDTO) throws StatusAccessDeniedException, StatusFailException {
        WebConfig webConfig = nacosSwitchConfig.getWebConfig();
        if(!webConfig.getRegister()) { // 需要判断一下网站是否开启注册
            throw new StatusAccessDeniedException("对不起！本站暂未开启注册功能！");
        }

        String codeKey = Constants.Email.REGISTER_KEY_PREFIX.getValue() + registerDTO.getEmail();
        if(!redisUtils.hasKey(codeKey)) {
            throw new StatusFailException("验证码不存在或已过期");
        }

        if(!redisUtils.get(codeKey).equals(registerDTO.getCode())) { //验证码判断
            throw new StatusFailException("验证码不正确");
        }

        if(StringUtils.isEmpty(registerDTO.getPassword())) {
            throw new StatusFailException("密码不能为空");
        }

        if(registerDTO.getPassword().length() < 6 || registerDTO.getPassword().length() > 20) {
            throw new StatusFailException("密码长度应该为6~20位！");
        }

        if(StringUtils.isEmpty(registerDTO.getUsername())) {
            throw new StatusFailException("用户名不能为空");
        }

        if(registerDTO.getUsername().length() > 20) {
            throw new StatusFailException("用户名长度不能超过20位!");
        }

        String uuid = IdUtil.simpleUUID();
        //为新用户设置uuid
        registerDTO.setUuid(uuid)
                .setPassword(SecureUtil.md5(registerDTO.getPassword()).trim()) // 将密码MD5加密写入数据库
                .setUsername(registerDTO.getUsername().trim())
                .setEmail(registerDTO.getEmail().trim());

        boolean addUser = userInfoEntityService.addUser(registerDTO);

        boolean addUserRole = userRoleEntityService.save(new UserRole().setRoleId(1002L).setUid(uuid));

        boolean addUserRecord = userRecordEntityService.save(new UserRecord().setUid(uuid));

        if(addUser && addUserRole && addUserRecord) {
            redisUtils.del(registerDTO.getEmail());
            noticeManager.syncNoticeToNewRegisterUser(uuid);
        } else {
            throw new StatusFailException("注册失败，请稍后重新尝试！");
        }

    }

    public void resetPassword(ResetPasswordDTO resetPasswordDTO) throws StatusFailException {
        String username = resetPasswordDTO.getUsername();
        String password = resetPasswordDTO.getPassword();
        String code = resetPasswordDTO.getCode();

        if(StringUtils.isEmpty(password) || StringUtils.isEmpty(username) || StringUtils.isEmpty(code))  {
            throw new StatusFailException("用户名、新密码或验证码不能为空");
        }

        if(password.length() < 6 || password.length()  > 20) {
            throw new StatusFailException("新密码长度应该为6~20位！");
        }

        String codeKey = Constants.Email.RESET_PASSWORD_KEY_PREFIX.getValue() + username;
        if(!redisUtils.hasKey(codeKey)) {
            throw new StatusFailException("重置密码链接不存在或已过期，请重新发送重置邮件");
        }

        if (!redisUtils.get(codeKey).equals(code)) {
            throw new StatusFailException("重置密码的验证码不正确，请重新输入");
        }

        UpdateWrapper<UserInfo> userInfoUpdateWrapper = new UpdateWrapper<>();
        userInfoUpdateWrapper.eq("username",username).set("password", SecureUtil.md5(password));
        boolean isOk = userInfoEntityService.update(userInfoUpdateWrapper);
        if(!isOk) {
            throw new StatusFailException("重置密码失败");
        }
        redisUtils.del(codeKey);
    }
}
