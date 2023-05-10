package com.github.loj.dao.contest.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestRegisterEntityService;
import com.github.loj.mapper.ContestRegisterMapper;
import com.github.loj.pojo.entity.contest.ContestRegister;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/10 22:54
 */
@Service
public class ContestRegisterEntityServiceImpl extends ServiceImpl<ContestRegisterMapper, ContestRegister> implements ContestRegisterEntityService {
}
