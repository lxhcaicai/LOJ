package com.github.loj.service.oj.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.oj.ProblemManager;
import com.github.loj.pojo.dto.PidListDTO;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.service.oj.ProblemService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
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

    @Override
    public CommonResult<HashMap<Long, Object>> getUserProblemStatus(PidListDTO pidListDTO) {
        try {
            return CommonResult.successResponse(problemManager.getUserProblemStatus(pidListDTO));
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        }
    }
}
