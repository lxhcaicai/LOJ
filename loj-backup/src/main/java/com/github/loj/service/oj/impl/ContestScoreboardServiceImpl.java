package com.github.loj.service.oj.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.oj.ContestScoreboardManager;
import com.github.loj.pojo.dto.ContestRankDTO;
import com.github.loj.pojo.vo.ContestOutsideInfoVO;
import com.github.loj.service.oj.ContestScoreboardService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class ContestScoreboardServiceImpl implements ContestScoreboardService {

    @Resource
    private ContestScoreboardManager contestScoreboardManager;

    @Override
    public CommonResult<IPage> getContestOutsideScoreboard(ContestRankDTO contestRankDTO) {
        try {
            return CommonResult.successResponse(contestScoreboardManager.getContestOutsideScoreboard(contestRankDTO));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<ContestOutsideInfoVO> getContestOutsideInfo(Long cid) {
        try {
            return CommonResult.successResponse(contestScoreboardManager.getContestOutsideInfo(cid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        }
    }
}
