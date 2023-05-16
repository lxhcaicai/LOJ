package com.github.loj.dao.training;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.vo.TrainingVO;

/**
 * @author lxhcaicai
 * @date 2023/5/11 0:16
 */
public interface TrainingEntityService extends IService<Training> {

    public Page<TrainingVO> getTrainingList(int limit,
                                            int currentPage,
                                            Long categoryId,
                                            String auth,
                                            String keyword,
                                            String currentUid);

}
