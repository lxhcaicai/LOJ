package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.dto.RegisterDTO;
import com.github.loj.pojo.entity.user.UserInfo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/22 18:53
 */
@Mapper
@Repository
public interface UserInfoMapper extends BaseMapper<UserInfo> {
    int addUser(RegisterDTO registerDTO);

    List<String> getSuperAdminUidList();

    List<String> getProblemAdminUidList();
}
