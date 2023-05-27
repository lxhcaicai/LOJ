package com.github.loj.dao.problem.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.problem.CategoryEntityService;
import com.github.loj.mapper.CategoryMapper;
import com.github.loj.pojo.entity.problem.Category;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/27 23:50
 */
@Service
public class CategoryEntityServiceImpl extends ServiceImpl<CategoryMapper,Category> implements CategoryEntityService {
}
