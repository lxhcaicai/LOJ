package com.github.loj.dao.judge.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.judge.JudgeCaseEntityService;
import com.github.loj.mapper.JudgeCaseMapper;
import com.github.loj.pojo.entity.judge.JudgeCase;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/8 23:49
 */
@Service
public class JudgeCaseEntityServiceImpl extends ServiceImpl<JudgeCaseMapper, JudgeCase> implements JudgeCaseEntityService {
}
