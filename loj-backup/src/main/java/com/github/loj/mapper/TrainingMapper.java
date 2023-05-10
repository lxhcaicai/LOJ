package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.vo.TrainingVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/11 0:18
 */
@Mapper
@Repository
public interface TrainingMapper extends BaseMapper<Training> {
    List<TrainingVO> getTrainingList(IPage page,
                                     @Param("categoryId") Long categoryId,
                                     @Param("auth") String auth,
                                     @Param("keyword") String keyword);
}
