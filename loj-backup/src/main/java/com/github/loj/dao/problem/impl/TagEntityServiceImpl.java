package com.github.loj.dao.problem.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.problem.TagEntityService;
import com.github.loj.mapper.TagMapper;
import com.github.loj.pojo.entity.problem.Tag;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/15 21:21
 */
@Service
public class TagEntityServiceImpl extends ServiceImpl<TagMapper, Tag> implements TagEntityService {
}
