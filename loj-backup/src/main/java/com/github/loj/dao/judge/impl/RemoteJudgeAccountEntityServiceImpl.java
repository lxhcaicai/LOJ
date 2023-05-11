package com.github.loj.dao.judge.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.judge.RemoteJudgeAccountEntityService;
import com.github.loj.mapper.RemoteJudgeAccountMapper;
import com.github.loj.pojo.entity.judge.RemoteJudgeAccount;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/11 22:45
 */
@Service
public class RemoteJudgeAccountEntityServiceImpl extends ServiceImpl<RemoteJudgeAccountMapper, RemoteJudgeAccount> implements RemoteJudgeAccountEntityService {
}
