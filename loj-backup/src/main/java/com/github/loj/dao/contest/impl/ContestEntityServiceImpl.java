package com.github.loj.dao.contest.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.mapper.ContestMapper;
import com.github.loj.pojo.entity.contest.Contest;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/8 21:03
 */
@Service
public class ContestEntityServiceImpl extends ServiceImpl<ContestMapper, Contest> implements ContestEntityService {
}
