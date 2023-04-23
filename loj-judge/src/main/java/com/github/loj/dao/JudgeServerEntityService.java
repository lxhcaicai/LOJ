package com.github.loj.dao;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.judge.JudgeServer;

import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/4/18 21:38
 */
public interface JudgeServerEntityService extends IService<JudgeServer> {
    public HashMap<String,Object> getJudgeServerInfo();
}
