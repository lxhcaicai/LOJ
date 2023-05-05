package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.pojo.entity.user.UserRecord;
import com.github.loj.pojo.vo.ACMRankVO;
import com.github.loj.pojo.vo.OIRankVO;
import com.github.loj.pojo.vo.UserHomeVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/5 21:00
 */
@Mapper
@Repository
public interface UserRecordMapper extends BaseMapper<UserRecord> {

    IPage<ACMRankVO> getACMRankList(Page<ACMRankVO> page, @Param("uidList") List<String> uidList);

    List<ACMRankVO> getRecent7ACRank();

    IPage<OIRankVO> getOIRankList(Page<OIRankVO> page, @Param("uidList") List<String> uidList);

    UserHomeVO getUserHomeInfo(@Param("uid") String uid, @Param("username") String username);

    IPage<OIRankVO> getGroupRankList(Page<OIRankVO> page,
                                     @Param("gid") Long gid,
                                     @Param("uidList") List<String> uidList,
                                     @Param("rankType") String rankType);
}
