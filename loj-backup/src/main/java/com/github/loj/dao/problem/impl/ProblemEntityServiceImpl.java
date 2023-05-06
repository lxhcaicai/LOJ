package com.github.loj.dao.problem.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.mapper.ProblemMapper;
import com.github.loj.pojo.entity.problem.Problem;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/7 0:32
 */
@Service
public class ProblemEntityServiceImpl extends ServiceImpl<ProblemMapper, Problem> implements ProblemEntityService {
}
