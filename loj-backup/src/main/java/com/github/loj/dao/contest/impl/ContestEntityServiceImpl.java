package com.github.loj.dao.contest.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.mapper.ContestMapper;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.ContestRegisterCountVO;
import com.github.loj.pojo.vo.ContestVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/8 21:03
 */
@Service
public class ContestEntityServiceImpl extends ServiceImpl<ContestMapper, Contest> implements ContestEntityService {

    @Autowired
    private ContestMapper contestMapper;

    @Override
    public List<ContestVO> getWithinNext14DaysContests() {
       List<ContestVO> contestList = contestMapper.getWithinNext14DaysContests();
        setRegisterCount(contestList);

        return contestList;
    }

    @Override
    public IPage<ContestVO> getContestList(Integer limit, Integer currentPage, Integer type, Integer status, String keyword) {
        // 新建分页
        IPage<ContestVO> page = new Page<>(currentPage, limit);

        List<ContestVO> contestList = contestMapper.getContestList(page, type, status, keyword);
        setRegisterCount(contestList);

        return page.setRecords(contestList);
    }

    @Override
    public ContestVO getContestInfoById(Long cid) {
        List<Long> cidList = Collections.singletonList(cid);
        ContestVO contestVO = contestMapper.getContestInfoById(cid);
        if(contestVO != null) {
            List<ContestRegisterCountVO> contestRegisterCountVOList = contestMapper.getContestRegisterCount(cidList);
            if(!CollectionUtils.isEmpty(contestRegisterCountVOList)) {
                ContestRegisterCountVO contestRegisterCountVO = contestRegisterCountVOList.get(0);
                contestVO.setCount(contestRegisterCountVO.getCount());
            }
        }
        return contestVO;
    }

    private void setRegisterCount(List<ContestVO> contestList) {
        List<Long> cidList = contestList.stream().map(ContestVO::getId).collect(Collectors.toList());
        if (!CollectionUtils.isEmpty(cidList)) {
            List<ContestRegisterCountVO> contestRegisterCountVOList = contestMapper.getContestRegisterCount(cidList);
            for(ContestRegisterCountVO contestRegisterCountVO: contestRegisterCountVOList) {
                for(ContestVO contestVO: contestList) {
                    if(contestRegisterCountVO.getCid().equals(contestVO.getId())) {
                        contestVO.setCount(contestRegisterCountVO.getCount());
                        break;
                    }
                }
            }
        }
    }
}
