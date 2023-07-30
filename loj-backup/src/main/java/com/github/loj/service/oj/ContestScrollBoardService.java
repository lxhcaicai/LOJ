package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.ContestScrollBoardInfoVO;
import com.github.loj.pojo.vo.ContestScrollBoardSubmissionVO;

import java.util.List;

public interface ContestScrollBoardService {
    public CommonResult<ContestScrollBoardInfoVO> getContestScrollBoardInfo(Long cid);

    public CommonResult<List<ContestScrollBoardSubmissionVO>> getContestScrollBoardSubmission(Long cid,Boolean removeStar);
}
