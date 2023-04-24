package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.pojo.entity.msg.UserSysNotice;
import com.github.loj.pojo.vo.SysMsgVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/4/24 21:21
 */
@Mapper
@Repository
public interface UserSysNoticeMapper extends BaseMapper<UserSysNotice> {
    IPage<SysMsgVO> getSysOrMineNotice(Page<SysMsgVO> page, @Param("uid") String uid, @Param("type") String type);
}
