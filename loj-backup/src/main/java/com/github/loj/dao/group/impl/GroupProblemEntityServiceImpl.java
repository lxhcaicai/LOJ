package com.github.loj.dao.group.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.group.GroupProblemEntityService;
import com.github.loj.mapper.GroupProblemMapper;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ProblemVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GroupProblemEntityServiceImpl extends ServiceImpl<GroupProblemMapper, Problem> implements GroupProblemEntityService {

    @Autowired
    private GroupProblemMapper groupProblemMapper;

    @Override
    public IPage<ProblemVO> getProblemList(Integer limit, Integer currentPage, Long gid) {
        IPage<ProblemVO> iPage = new Page<>(currentPage, limit);

        List<ProblemVO> problemVOList = groupProblemMapper.getProblemList(iPage, gid);

        return iPage.setRecords(problemVOList);
    }
}
