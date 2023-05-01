package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.problem.ProblemCase;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/5/2 0:30
 */
@Mapper
@Repository
public interface ProblemCaseMapper extends BaseMapper<ProblemCase> {
}
