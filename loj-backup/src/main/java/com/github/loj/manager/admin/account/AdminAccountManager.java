package com.github.loj.manager.admin.account;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.crypto.SecureUtil;
import com.github.loj.common.exception.StatusAccessDeniedException;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.user.SessionEntityService;
import com.github.loj.dao.user.UserRoleEntityService;
import com.github.loj.pojo.dto.LoginDTO;
import com.github.loj.pojo.entity.user.Role;
import com.github.loj.pojo.entity.user.Session;
import com.github.loj.pojo.vo.UserInfoVO;
import com.github.loj.pojo.vo.UserRolesVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.utils.IpUtils;
import com.github.loj.utils.JwtUtils;
import com.github.loj.utils.RedisUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/4/24 2:03
 */
@Component
public class AdminAccountManager {
    @Autowired
    private SessionEntityService sessionEntityService;

    @Autowired
    private JwtUtils jwtUtils;

    @Resource
    private RedisUtils redisUtils;

    @Autowired
    private UserRoleEntityService userRoleEntityService;


    public UserInfoVO login(LoginDTO loginDTO) throws StatusFailException, StatusAccessDeniedException {
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = servletRequestAttributes.getRequest();
        HttpServletResponse response = servletRequestAttributes.getResponse();

        String userIpAddr = IpUtils.getUserIpAddr(request);
        String key = Constants.Account.TRY_LOGIN_NUM.getCode() + loginDTO.getUsername() + "_" + userIpAddr;
        Integer tryLoginCount = (Integer) redisUtils.get(key);

        if(tryLoginCount != null && tryLoginCount >= 20) {
            throw new StatusFailException("对不起！登录失败次数过多！您的账号有风险，半个小时内暂时无法登录！");
        }

        UserRolesVO userRolesVO = userRoleEntityService.getUserRoles(null, loginDTO.getUsername());

        if(userRolesVO == null) {
            throw new StatusFailException("用户名或密码错误");
        }

        if(!userRolesVO.getPassword().equals(SecureUtil.md5(loginDTO.getPassword()))) {
            if(tryLoginCount == null) {
                redisUtils.set(key, 1, 60 * 30); // 三十分钟不尝试，该限制会自动清空消失
            } else {
                redisUtils.set(key, tryLoginCount + 1, 60 * 30);
            }
            throw new StatusFailException("用户名或密码错误");
        }

        if(userRolesVO.getStatus() != 0) {
            throw new StatusFailException("该账户已被封禁，请联系管理员进行处理！");
        }

        // 认证成功清除锁定限制
        if(tryLoginCount != null) {
            redisUtils.del(key);
        }

        List<String> roleList = new LinkedList<>();
        userRolesVO.getRoles().stream()
                .forEach(role -> roleList.add(role.getRole()));

        if(roleList.contains("admin") || roleList.contains("root") || roleList.contains("problem_admin")) { // 超级管理员或管理员、题目管理员
            String jwt = jwtUtils.generateToken(userRolesVO.getUid());

            response.setHeader("Authorization", jwt);
            response.setHeader("Access-Control-Expose-Headers", "Authorization");

            // 会话记录
            sessionEntityService.save(new Session().setUid(userRolesVO.getUid())
                    .setIp(IpUtils.getUserIpAddr(request)).setUserAgent(request.getHeader("User-Agent")));

            // 异步检查是否异地登录

            sessionEntityService.checkRemoteLogin(userRolesVO.getUid());

            UserInfoVO userInfoVO = new UserInfoVO();
            BeanUtil.copyProperties(userRolesVO, userInfoVO, "roles");
            userInfoVO.setRoleList(userRolesVO.getRoles()
                    .stream()
                    .map(Role::getRole)
                    .collect(Collectors.toList()));

            return userInfoVO;

        } else {
            throw  new StatusAccessDeniedException("该账号并非管理员账号，无权登录！");
        }

    }

    public void logout() {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        jwtUtils.cleanToken(userRolesVo.getUid());
        SecurityUtils.getSubject().logout();
    }
}
