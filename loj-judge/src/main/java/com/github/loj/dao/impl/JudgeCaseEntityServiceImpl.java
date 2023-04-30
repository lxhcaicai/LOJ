package com.github.loj.dao.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.JudgeCaseEntityService;
import com.github.loj.mapper.JudgeCaseMapper;
import com.github.loj.pojo.entity.judge.JudgeCase;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/4/30 11:18
 */
@Service
public class JudgeCaseEntityServiceImpl extends ServiceImpl<JudgeCaseMapper, JudgeCase> implements JudgeCaseEntityService {
}
