package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.pojo.entity.msg.AdminSysNotice;
import com.github.loj.pojo.vo.AdminSysNoticeVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/4/24 20:56
 */
@Mapper
@Repository
public interface AdminSysNoticeMapper extends BaseMapper<AdminSysNotice> {
    IPage<AdminSysNoticeVO> getAdminSysNotice(Page<AdminSysNoticeVO> page, @Param("type") String type);
}
