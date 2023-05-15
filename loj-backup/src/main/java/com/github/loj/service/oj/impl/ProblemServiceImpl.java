package com.github.loj.service.oj.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.ProblemManager;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.service.oj.ProblemService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/15 21:55
 */
@Service
public class ProblemServiceImpl implements ProblemService {

    @Resource
    private ProblemManager problemManager;

    @Override
    public CommonResult<Page<ProblemVO>> getProblemList(Integer limit, Integer currentPage, String keyword, List<Long> tagId, Integer difficulty, String oj) {
        return CommonResult.successResponse(problemManager.getProblemList(limit,currentPage, keyword, tagId, difficulty, oj));
    }
}
