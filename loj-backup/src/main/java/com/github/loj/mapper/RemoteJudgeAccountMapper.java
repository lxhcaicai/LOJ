package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.judge.RemoteJudgeAccount;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/11 22:04
 */
@Mapper
@Repository
public interface RemoteJudgeAccountMapper extends BaseMapper<RemoteJudgeAccount> {

    @Select("select * from `remote_judge_account` where `oj` = #{oj} and `status` = 1 for update")
    public List<RemoteJudgeAccount> getAvailableAccount(@Param("oj") String oj);

    @Update("update `remote_judge_account` set `status` = 0 where `id` = #{id} and `status` = 1")
    public int updateAccountStatusById(@Param("id") Integer id);

}
