package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.pojo.entity.common.Announcement;
import com.github.loj.pojo.vo.AnnouncementVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface GroupAnnouncementMapper extends BaseMapper<Announcement> {

    List<AnnouncementVO> getAnnouncementList(IPage iPage, @Param("gid") Long gid);

    List<AnnouncementVO> getAdminAnnouncementList(IPage iPage, @Param("gid") Long gid);
}
