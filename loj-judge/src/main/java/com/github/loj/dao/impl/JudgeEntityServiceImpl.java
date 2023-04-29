package com.github.loj.dao.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.JudgeEntityService;
import com.github.loj.mapper.JudgeMapper;
import com.github.loj.pojo.entity.judge.Judge;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/4/29 22:45
 */
@Service
public class JudgeEntityServiceImpl extends ServiceImpl<JudgeMapper, Judge> implements JudgeEntityService {
}
