package com.github.loj.dao.training.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.training.TrainingRegisterEntityService;
import com.github.loj.mapper.TrainingRegisterMapper;
import com.github.loj.pojo.entity.training.TrainingRegister;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/11 0:46
 */
@Service
public class TrainingRegisterEntityServiceImpl extends ServiceImpl<TrainingRegisterMapper, TrainingRegister> implements TrainingRegisterEntityService {

    @Resource
    private TrainingRegisterMapper trainingRegisterMapper;

    @Override
    public List<String> getAlreadyRegisterUidList(Long tid) {
        QueryWrapper<TrainingRegister> trainingRegisterQueryWrapper = new QueryWrapper<>();
        trainingRegisterQueryWrapper.eq("tid", tid);
        return trainingRegisterMapper.selectList(trainingRegisterQueryWrapper)
                .stream().map(TrainingRegister::getUid).collect(Collectors.toList());
    }
}
