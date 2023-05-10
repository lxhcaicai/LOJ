package com.github.loj.dao.training.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.training.TrainingEntityService;
import com.github.loj.mapper.TrainingMapper;
import com.github.loj.pojo.entity.training.Training;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/11 0:16
 */
@Service
public class TrainingEntityServiceImpl extends ServiceImpl<TrainingMapper, Training> implements TrainingEntityService {
}
