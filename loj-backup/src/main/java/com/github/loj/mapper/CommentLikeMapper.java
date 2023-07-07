package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.discussion.CommentLike;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @author lxhcaicai
 * @date 2023/5/25 1:37
 */
@Mapper
@Repository
public interface CommentLikeMapper extends BaseMapper<CommentLike> {
}
