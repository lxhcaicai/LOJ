package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.ContestScrollBoardInfoVO;

public interface ContestScrollBoardService {
    public CommonResult<ContestScrollBoardInfoVO> getContestScrollBoardInfo(Long cid);
}
