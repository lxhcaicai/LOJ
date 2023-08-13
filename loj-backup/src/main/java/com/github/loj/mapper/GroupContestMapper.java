package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.ContestVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface GroupContestMapper extends BaseMapper<Contest> {
    List<ContestVO> getContestList(IPage iPage, @Param("gid") Long gid);

    List<Contest> getAdminContestList(IPage iPage, @Param("gid") Long gid);
}
