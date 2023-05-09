package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.user.UserAcproblem;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/5/9 20:44
 */
@Mapper
@Repository
public interface UserAcproblemMapper extends BaseMapper<UserAcproblem> {
}
