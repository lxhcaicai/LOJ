package com.github.loj.dao.training;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.training.TrainingRecord;
import com.github.loj.pojo.vo.TrainingRecordVO;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 22:58
 */
public interface TrainingRecordEntityService extends IService<TrainingRecord> {

    public List<TrainingRecordVO> getTrainingRecord(Long tid);

}
