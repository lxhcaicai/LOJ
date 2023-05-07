package com.github.loj.dao.training.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.training.TrainingRecordEntityService;
import com.github.loj.mapper.TrainingRecordMapper;
import com.github.loj.pojo.entity.training.TrainingRecord;
import com.github.loj.pojo.vo.TrainingRecordVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 23:05
 */
@Service
public class TrainingRecordEntityServiceImpl extends ServiceImpl<TrainingRecordMapper, TrainingRecord> implements TrainingRecordEntityService {

    @Resource
    private TrainingRecordMapper trainingRecordMapper;

    @Override
    public List<TrainingRecordVO> getTrainingRecord(Long tid) {
        return trainingRecordMapper.getTrainingRecord(tid);
    }
}