package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ProblemVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface GroupProblemMapper extends BaseMapper<Problem> {

    List<ProblemVO> getProblemList(IPage iPage, @Param("gid") Long gid);

    List<Problem> getAdminProblemList(IPage iPage, @Param("gid") Long gid);
}
