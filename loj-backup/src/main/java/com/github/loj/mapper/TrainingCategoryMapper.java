package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.training.TrainingCategory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/5/16 21:54
 */
@Mapper
@Repository
public interface TrainingCategoryMapper extends BaseMapper<TrainingCategory> {

    public TrainingCategory getTrainingCategoryByTrainingId(@Param("tid") Long tid);

}
