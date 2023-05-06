package com.github.loj.dao.judge.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.judge.JudgeServerEntityService;
import com.github.loj.mapper.JudgeServerMapper;
import com.github.loj.pojo.entity.judge.JudgeServer;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/7 2:21
 */
@Service
public class JudgeServerEntityServiceImpl extends ServiceImpl<JudgeServerMapper, JudgeServer> implements JudgeServerEntityService {
}
