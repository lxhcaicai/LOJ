package com.github.loj.dao.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.UserAcproblemEntityService;
import com.github.loj.mapper.UserAcproblemMapper;
import com.github.loj.pojo.entity.user.UserAcproblem;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/4/29 23:03
 */
@Service
public class UserAcproblemEntityServiceImpl extends ServiceImpl<UserAcproblemMapper, UserAcproblem> implements UserAcproblemEntityService {
}
