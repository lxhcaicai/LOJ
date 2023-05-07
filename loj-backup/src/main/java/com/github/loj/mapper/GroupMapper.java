package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.vo.GroupVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 21:50
 */
@Mapper
@Repository
public interface GroupMapper extends BaseMapper<Group> {
    List<GroupVO> getGroupList(IPage iPage,
                               @Param("keyword") String keyword,
                               @Param("auth") Integer auth,
                               @Param("uid") String uid,
                               @Param("onlyMine") Boolean onlyMine,
                               @Param("isRoot") Boolean isRoot);
}
