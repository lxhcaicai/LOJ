package com.github.loj.dao.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.ProblemEntityService;
import com.github.loj.mapper.ProblemMapper;
import com.github.loj.pojo.entity.problem.Problem;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/1 20:33
 */
@Service
public class ProblemEntityServiceImpl extends ServiceImpl<ProblemMapper, Problem> implements ProblemEntityService {
}
