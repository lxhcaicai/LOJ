package com.github.loj.dao.problem.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.problem.LanguageEntityService;
import com.github.loj.mapper.LanguageMapper;
import com.github.loj.pojo.entity.problem.Language;
import org.springframework.stereotype.Service;

@Service
public class LanguageEntityServiceImpl extends ServiceImpl<LanguageMapper, Language> implements LanguageEntityService {
}
