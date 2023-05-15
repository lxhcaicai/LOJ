package com.github.loj.dao.problem.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.problem.TagClassificationEntityService;
import com.github.loj.mapper.TagClassificationMapper;
import com.github.loj.pojo.entity.problem.TagClassification;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/15 21:16
 */
@Service
public class TagClassificationEntityServiceImpl extends ServiceImpl<TagClassificationMapper, TagClassification> implements TagClassificationEntityService {
}
