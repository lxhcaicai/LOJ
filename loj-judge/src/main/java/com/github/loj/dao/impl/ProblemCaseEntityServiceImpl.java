package com.github.loj.dao.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.ProblemCaseEntityService;
import com.github.loj.mapper.ProblemCaseMapper;
import com.github.loj.pojo.entity.problem.ProblemCase;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/2 0:29
 */
@Service
public class ProblemCaseEntityServiceImpl extends ServiceImpl<ProblemCaseMapper, ProblemCase> implements ProblemCaseEntityService {
}
