package com.github.loj.dao.user.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.user.UserRoleEntityService;
import com.github.loj.mapper.UserRoleMapper;
import com.github.loj.pojo.entity.user.Role;
import com.github.loj.pojo.entity.user.UserRole;
import com.github.loj.pojo.vo.UserRolesVO;
import com.github.loj.shiro.ShiroConstant;
import com.github.loj.utils.RedisUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.session.Session;
import org.crazycake.shiro.RedisSessionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/22 3:00
 */
@Service
@Slf4j(topic = "loj")
public class UserRoleEntityServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements UserRoleEntityService {

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private RedisSessionDAO redisSessionDAO;

    @Override
    public UserRolesVO getUserRoles(String uid, String username) {
        return userRoleMapper.getUserRoles(uid, username);
    }

    @Override
    public List<Role> getRolesByUid(String uid) {
        return userRoleMapper.getRolesByUid(uid);
    }

    @Override
    public IPage<UserRolesVO> getUserList(int limit, int currentPage, String keyword, Boolean onlyAdmin) {
        // 新建分页
        Page<UserRolesVO> page = new Page<>(currentPage,limit);
        if(onlyAdmin) {
            return userRoleMapper.getAdminUserList(page, limit, currentPage, keyword);
        } else {
            return userRoleMapper.getUserList(page, limit, currentPage, keyword);
        }
    }

    @Override
    public void deleteCache(String uid, boolean isRemoveSession) {
        if(isRemoveSession) {
            redisUtils.del(ShiroConstant.SHIRO_TOKEN_KEY + uid,
                    ShiroConstant.SHIRO_TOKEN_REFRESH + uid,
                    ShiroConstant.SHIRO_AUTHORIZATION_CACHE + uid);
        } else {
            redisUtils.del(ShiroConstant.SHIRO_AUTHORIZATION_CACHE + uid);
        }
    }

    private final static List<String> ChineseRole = Arrays.asList("超级管理员", "普通管理员",
            "普通用户(默认)", "普通用户(禁止提交)", "普通用户(禁止发讨论)", "普通用户(禁言)", "普通用户(禁止提交&禁止发讨论)",
            "用户(禁止提交&禁言)", "题目管理员");

    private final static List<String> EnglishRole = Arrays.asList("Super Administrator", "General Administrator",
            "Normal User(Default)", "Normal User(No Submission)", "Normal User(No Discussion)", "Normal User(Forbidden Words)",
            "Normal User(No Submission & No Discussion)",
            "Normal User(No Submission & Forbidden Words)", "Problem Administrator");

    @Override
    public String getAuthChangeContent(int oldType, int newType) {
        String msg = "您好，您的权限产生了变更，由【" +
                ChineseRole.get(oldType - 1000) +
                "】变更为【" +
                ChineseRole.get(newType - 1000) +
                "】。部分权限可能与之前有所不同，请您注意！" +
                "\n\n" +
                "Hello, your permission has been changed from 【" +
                EnglishRole.get(oldType - 1000) +
                "】 to 【" +
                EnglishRole.get(newType - 1000) +
                "】. Some permissions may be different from before. Please note!";
        return msg;
    }

    private void deleteSession(boolean isRemoveSession, Session session, String uid) {
        //删除session 会强制退出！主要是在禁用用户或角色时，强制用户退出的
        if(isRemoveSession) {
            redisSessionDAO.delete(session);
        }
        // 删除Cache, 在访问受限接口时会重新授权
        redisUtils.del(ShiroConstant.SHIRO_AUTHORIZATION_CACHE + uid);
    }
}
