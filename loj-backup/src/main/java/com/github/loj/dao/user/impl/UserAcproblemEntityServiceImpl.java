package com.github.loj.dao.user.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.user.UserAcproblemEntityService;
import com.github.loj.mapper.UserAcproblemMapper;
import com.github.loj.pojo.entity.user.UserAcproblem;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/9 20:43
 */
@Service
public class UserAcproblemEntityServiceImpl extends ServiceImpl<UserAcproblemMapper, UserAcproblem> implements UserAcproblemEntityService {
}
