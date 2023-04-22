package com.github.loj.dao.user;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.dto.RegisterDTO;
import com.github.loj.pojo.entity.user.UserInfo;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/22 18:30
 */
public interface UserInfoEntityService extends IService<UserInfo> {
    public Boolean addUser(RegisterDTO registerDTO);

    public List<String> getSuperAdminUidList();

    public List<String> getProblemAdminUidList();
}
