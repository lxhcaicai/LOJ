package com.github.loj.dao.problem.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.problem.ProblemTagEntityService;
import com.github.loj.mapper.ProblemTagMapper;
import com.github.loj.pojo.entity.problem.ProblemTag;
import org.springframework.stereotype.Service;

@Service
public class ProblemTagEntityServiceImpl extends ServiceImpl<ProblemTagMapper, ProblemTag> implements ProblemTagEntityService {
}
