package com.github.loj.dao.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.RemoteJudgeAccountEntityService;
import com.github.loj.mapper.RemoteJudgeAccountMapper;
import com.github.loj.pojo.entity.judge.RemoteJudgeAccount;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/4/30 9:40
 */
@Service
public class RemoteJudgeAccountEntityServiceImpl extends ServiceImpl<RemoteJudgeAccountMapper, RemoteJudgeAccount> implements RemoteJudgeAccountEntityService {
}
