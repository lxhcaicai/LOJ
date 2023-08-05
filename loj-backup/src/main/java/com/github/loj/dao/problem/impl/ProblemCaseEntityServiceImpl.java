package com.github.loj.dao.problem.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.problem.ProblemCaseEntityService;
import com.github.loj.mapper.ProblemCaseMapper;
import com.github.loj.pojo.entity.problem.ProblemCase;
import org.springframework.stereotype.Service;

@Service
public class ProblemCaseEntityServiceImpl extends ServiceImpl<ProblemCaseMapper, ProblemCase> implements ProblemCaseEntityService {
}
