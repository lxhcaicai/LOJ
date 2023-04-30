package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.judge.RemoteJudgeAccount;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/4/30 9:41
 */
@Mapper
@Repository
public interface RemoteJudgeAccountMapper extends BaseMapper<RemoteJudgeAccount> {
}
