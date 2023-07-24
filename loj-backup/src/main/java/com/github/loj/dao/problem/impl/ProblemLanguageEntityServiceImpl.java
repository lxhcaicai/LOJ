package com.github.loj.dao.problem.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.problem.ProblemLanguageEntityService;
import com.github.loj.mapper.ProblemLanguageMapper;
import com.github.loj.pojo.entity.problem.ProblemLanguage;
import org.springframework.stereotype.Service;

@Service
public class ProblemLanguageEntityServiceImpl extends ServiceImpl<ProblemLanguageMapper, ProblemLanguage> implements ProblemLanguageEntityService {
}
