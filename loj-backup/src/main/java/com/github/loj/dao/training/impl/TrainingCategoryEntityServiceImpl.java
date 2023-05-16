package com.github.loj.dao.training.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.training.TrainingCategoryEntityService;
import com.github.loj.mapper.TrainingCategoryMapper;
import com.github.loj.pojo.entity.training.TrainingCategory;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/16 21:53
 */
@Service
public class TrainingCategoryEntityServiceImpl extends ServiceImpl<TrainingCategoryMapper,TrainingCategory> implements TrainingCategoryEntityService {
}
