package com.github.loj.service.oj.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.oj.ContestScrollBoardManager;
import com.github.loj.pojo.dto.ContestRankDTO;
import com.github.loj.service.oj.ContestScrollBoardService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class ContestScrollBoardServiceImpl implements ContestScrollBoardService {

    @Resource
    private ContestScrollBoardManager contestScrollBoardManager;

    @Override
    public CommonResult<IPage> getContestOutsideScoreboard(ContestRankDTO contestRankDTO) {
        try {
            return CommonResult.successResponse(contestScrollBoardManager.getContestOutsideScoreboard(contestRankDTO));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
