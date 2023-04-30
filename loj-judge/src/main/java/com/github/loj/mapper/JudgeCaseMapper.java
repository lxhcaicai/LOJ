package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.judge.JudgeCase;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/4/30 11:19
 */
@Mapper
@Repository
public interface JudgeCaseMapper extends BaseMapper<JudgeCase> {
}
