package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.pojo.vo.DiscussionVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:44
 */
@Mapper
@Repository
public interface DiscussionMapper extends BaseMapper<Discussion> {
    DiscussionVO getDiscussion(@Param("did") Integer did, @Param("uid") String uid);
}
