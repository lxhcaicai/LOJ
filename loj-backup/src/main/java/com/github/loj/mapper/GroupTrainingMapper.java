package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.vo.TrainingVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface GroupTrainingMapper extends BaseMapper<Training> {
    List<TrainingVO> getTrainingList(IPage iPage, @Param("gid") Long gid);

    List<Training> getAdminTrainingList(IPage iPage, @Param("gid") Long gid);
}
