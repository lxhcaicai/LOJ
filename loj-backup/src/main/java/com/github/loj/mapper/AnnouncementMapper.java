package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.pojo.entity.common.Announcement;
import com.github.loj.pojo.vo.AnnouncementVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/5/15 19:59
 */

@Mapper
@Repository
public interface AnnouncementMapper extends BaseMapper<Announcement> {
    IPage<AnnouncementVO> getAnnouncementList(Page<AnnouncementVO> page, @Param("notAdmin") Boolean notAdmin);
    IPage<AnnouncementVO> getContestAnnouncement(Page<AnnouncementVO> page, @Param("cid") Long cid, @Param("notAdmin") Boolean notAdmin);
}
