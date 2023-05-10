package com.github.loj.dao.training.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.training.TrainingRegisterEntityService;
import com.github.loj.mapper.TrainingRegisterMapper;
import com.github.loj.pojo.entity.training.TrainingRegister;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/11 0:46
 */
@Service
public class TrainingRegisterEntityServiceImpl extends ServiceImpl<TrainingRegisterMapper, TrainingRegister> implements TrainingRegisterEntityService {
}
