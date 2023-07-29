package com.github.loj.dao.contest.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestPrintEntityService;
import com.github.loj.mapper.ContestPrintMapper;
import com.github.loj.pojo.entity.contest.ContestPrint;
import org.springframework.stereotype.Service;

@Service
public class ContestPrintEntityServiceImpl extends ServiceImpl<ContestPrintMapper,ContestPrint> implements ContestPrintEntityService {
}
