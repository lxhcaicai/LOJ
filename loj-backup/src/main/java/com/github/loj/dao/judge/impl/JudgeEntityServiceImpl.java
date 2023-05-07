package com.github.loj.dao.judge.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.mapper.JudgeMapper;
import com.github.loj.pojo.entity.judge.Judge;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/7 22:14
 */
@Service
@Slf4j(topic = "loj")
public class JudgeEntityServiceImpl extends ServiceImpl<JudgeMapper, Judge> implements JudgeEntityService {
}
