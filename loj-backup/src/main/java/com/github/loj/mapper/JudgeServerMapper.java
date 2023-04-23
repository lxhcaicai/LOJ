package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.judge.JudgeServer;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/4/23 23:09
 */
@Mapper
@Repository
public interface JudgeServerMapper extends BaseMapper<JudgeServer> {
}
