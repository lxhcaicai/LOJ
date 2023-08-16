package com.github.loj.dao.training;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.training.TrainingRegister;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/11 0:46
 */
public interface TrainingRegisterEntityService extends IService<TrainingRegister> {
    public List<String> getAlreadyRegisterUidList(Long tid);
}
