package com.github.loj.dao.user.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.mapper.UserInfoMapper;
import com.github.loj.pojo.dto.RegisterDTO;
import com.github.loj.pojo.entity.user.UserInfo;
import com.github.loj.util.Constants;
import com.github.loj.utils.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/22 18:52
 */
public class UserInfoEntityServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements UserInfoEntityService {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private RedisUtils redisUtils;

    @Override
    public Boolean addUser(RegisterDTO registerDTO) {
        return userInfoMapper.addUser(registerDTO) == 1;
    }

    @Override
    public List<String> getSuperAdminUidList() {

        String cacheKey = Constants.Account.SUPER_ADMIN_UID_LIST_CACHE.getCode();
        List<String> superAdminUidList  = (List<String>) redisUtils.get(cacheKey);
        if(superAdminUidList == null) {
            superAdminUidList = userInfoMapper.getSuperAdminUidList();
            redisUtils.set(cacheKey, superAdminUidList, 12 * 3600);
        }
        return superAdminUidList;
    }

    @Override
    public List<String> getProblemAdminUidList() {
        return userInfoMapper.getProblemAdminUidList();
    }
}
