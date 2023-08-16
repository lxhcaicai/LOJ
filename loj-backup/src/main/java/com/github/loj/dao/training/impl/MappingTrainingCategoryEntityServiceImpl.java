package com.github.loj.dao.training.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.training.MappingTrainingCategoryEntityService;
import com.github.loj.mapper.MappingTrainingCategoryMapper;
import com.github.loj.pojo.entity.training.MappingTrainingCategory;
import org.springframework.stereotype.Service;

@Service
public class MappingTrainingCategoryEntityServiceImpl extends ServiceImpl<MappingTrainingCategoryMapper, MappingTrainingCategory> implements MappingTrainingCategoryEntityService {
}
