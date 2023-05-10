package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.contest.ContestRegister;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/5/10 22:55
 */
@Mapper
@Repository
public interface ContestRegisterMapper extends BaseMapper<ContestRegister> {
}
