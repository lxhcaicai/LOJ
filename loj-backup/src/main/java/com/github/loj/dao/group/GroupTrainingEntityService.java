package com.github.loj.dao.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.vo.TrainingVO;

public interface GroupTrainingEntityService extends IService<Training> {
    IPage<TrainingVO> getTrainingList(Integer limit, Integer currentPage, Long gid);
}
