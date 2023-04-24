package com.github.loj.dao.user;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.user.Session;

/**
 * @author lxhcaicai
 * @date 2023/4/24 2:06
 */
public interface SessionEntityService extends IService<Session> {

    public void checkRemoteLogin(String uid);

}
