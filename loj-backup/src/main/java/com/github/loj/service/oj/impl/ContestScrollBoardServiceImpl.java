package com.github.loj.service.oj.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.ContestScrollBoardManager;
import com.github.loj.pojo.vo.ContestScrollBoardInfoVO;
import com.github.loj.pojo.vo.ContestScrollBoardSubmissionVO;
import com.github.loj.service.oj.ContestScrollBoardService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ContestScrollBoardServiceImpl implements ContestScrollBoardService {

    @Resource
    private ContestScrollBoardManager contestScrollBoardManager;
    @Override
    public CommonResult<ContestScrollBoardInfoVO> getContestScrollBoardInfo(Long cid) {
        try {
            return CommonResult.successResponse(contestScrollBoardManager.getContestScrollBoardInfo(cid));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<List<ContestScrollBoardSubmissionVO>> getContestScrollBoardSubmission(Long cid, Boolean removeStar) {
        try {
            return CommonResult.successResponse(contestScrollBoardManager.getContestScrollBoardSubmission(cid,removeStar));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
