package com.github.loj.dao.problem.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.mapper.ProblemMapper;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ProblemCountVO;
import com.github.loj.pojo.vo.ProblemVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/7 0:32
 */
@Service
public class ProblemEntityServiceImpl extends ServiceImpl<ProblemMapper, Problem> implements ProblemEntityService {

    @Autowired
    private ProblemMapper problemMapper;

    @Autowired
    private JudgeEntityService judgeEntityService;

    @Override
    public Page<ProblemVO> getProblemList(int limit, int currentPage, Long pid, String title, Integer difficulty, List<Long> tid, String oj) {

        // 新建分页
        Page<ProblemVO> page = new Page<>(currentPage, limit);
        Integer tagListSize = null;
        if(tid != null) {
            tid = tid.stream().distinct().collect(Collectors.toList());;
            tagListSize = tid.size();
        }

        List<ProblemVO> problemList = problemMapper.getProblemList(page,pid, title, difficulty, tid, tagListSize, oj);

        if(problemList.size() > 0) {
            List<Long> pidList = problemList.stream().map(ProblemVO::getPid).collect(Collectors.toList());
            List<ProblemCountVO> problemListCount = judgeEntityService.getProblemListCount(pidList);
            for(ProblemVO problemVO: problemList) {
                for(ProblemCountVO problemCountVO: problemListCount) {
                    if(problemVO.getPid().equals(problemCountVO.getPid())) {
                        problemVO.setProblemCountVo(problemCountVO);
                        break;
                    }
                }
            }
        }
        return page.setRecords(problemList);
    }
}
