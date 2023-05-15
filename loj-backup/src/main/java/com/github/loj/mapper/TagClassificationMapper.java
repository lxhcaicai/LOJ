package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.problem.TagClassification;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/5/15 21:17
 */
@Mapper
@Repository
public interface TagClassificationMapper extends BaseMapper<TagClassification> {
}
