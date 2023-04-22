package com.github.loj.shiro;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.dao.user.UserRoleEntityService;
import com.github.loj.mapper.RoleAuthMapper;
import com.github.loj.pojo.entity.user.Auth;
import com.github.loj.pojo.entity.user.Role;
import com.github.loj.pojo.entity.user.UserInfo;
import com.github.loj.utils.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/22 2:31
 */
@Slf4j
@Component
public class AccountRealm  extends AuthorizingRealm {

    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private UserRoleEntityService userRoleEntityService;

    @Autowired
    private UserInfoEntityService userInfoEntityService;

    @Autowired
    private RoleAuthMapper roleAuthMapper;

    @Override
    public boolean supports(AuthenticationToken token) {
        return token instanceof JwtToken;
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        AccountProfile user = (AccountProfile) principalCollection.getPrimaryPrincipal();
        // 角色权限列表
        List<String> permissionsNameList = new LinkedList<>();
        // 用户角色列表
        List<String> roleNameList = new LinkedList<>();
        // 获取该用户角色所有权限
        List<Role> roles =  userRoleEntityService.getRolesByUid(user.getUid());
        for (Role role: roles) {
            roleNameList.add(role.getRole());
            for(Auth auth: roleAuthMapper.getRoleAuths(role.getId()).getAuths()) {
                permissionsNameList.add(auth.getPermission());
            }
        }
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();

        authorizationInfo.addRoles(roleNameList);
        // 添加权限
        authorizationInfo.addStringPermissions(permissionsNameList);
        return authorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        JwtToken jwt = (JwtToken) authenticationToken;

        String userId = jwtUtils.getClaimByToken((String)jwt.getPrincipal()).getSubject();

        QueryWrapper<UserInfo> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("uuid", userId)
                .select("uuid", "username", "nickname", "realname", "title_name", "title_color", "avatar", "status");

        UserInfo userInfo = userInfoEntityService.getOne(queryWrapper, false);
        if(userInfo == null) {
            throw  new UnknownAccountException("账户不存在! ");
        }
        if(userInfo.getStatus() == 1) {
            throw new LockedAccountException("该账户已被封禁,请联系管理员进行处理");
        }

        AccountProfile profile = new AccountProfile();
        BeanUtil.copyProperties(userInfo, profile);
        profile.setUid(userInfo.getUuid());
        return new SimpleAuthenticationInfo(profile, jwt.getCredentials(), getName());
    }
}
