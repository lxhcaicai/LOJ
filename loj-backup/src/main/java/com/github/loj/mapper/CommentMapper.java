package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.pojo.entity.discussion.Comment;
import com.github.loj.pojo.vo.CommentVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/25 1:10
 */
@Mapper
@Repository
public interface CommentMapper extends BaseMapper<Comment> {

    IPage<CommentVO> getCommentList(Page<CommentVO> page,
                                    @Param("cid") Long cid,
                                    @Param("did") Integer did,
                                    @Param("onlyMineAndAdmin") Boolean onlyMineAndAdmin,
                                    @Param("myAndAdminUidList")List<String> myAndAdminUidList);

}
