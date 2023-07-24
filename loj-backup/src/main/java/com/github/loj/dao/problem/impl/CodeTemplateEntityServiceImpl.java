package com.github.loj.dao.problem.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.problem.CodeTemplateEntityService;
import com.github.loj.mapper.CodeTemplateMapper;
import com.github.loj.pojo.entity.problem.CodeTemplate;
import org.springframework.stereotype.Service;

@Service
public class CodeTemplateEntityServiceImpl extends ServiceImpl<CodeTemplateMapper,CodeTemplate> implements CodeTemplateEntityService {
}
