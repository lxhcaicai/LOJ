package com.github.loj.dao.contest.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestProblemEntityService;
import com.github.loj.mapper.ContestProblemMapper;
import com.github.loj.pojo.entity.contest.ContestProblem;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/10 23:42
 */
@Service
public class ContestProblemEntityServiceImpl extends ServiceImpl<ContestProblemMapper, ContestProblem> implements ContestProblemEntityService {
}
