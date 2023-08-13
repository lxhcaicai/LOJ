package com.github.loj.dao.group.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.group.GroupContestEntityService;
import com.github.loj.mapper.GroupContestMapper;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.ContestVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GroupContestEntityServiceImpl extends ServiceImpl<GroupContestMapper, Contest> implements GroupContestEntityService {

    @Autowired
    private GroupContestMapper groupContestMapper;

    @Override
    public IPage<ContestVO> getContestList(Integer limit, Integer currentPage, Long gid) {
        IPage<ContestVO> iPage = new Page<>(currentPage,limit);

        List<ContestVO> contestList =groupContestMapper.getContestList(iPage,gid);
        return iPage.setRecords(contestList);
    }
}
