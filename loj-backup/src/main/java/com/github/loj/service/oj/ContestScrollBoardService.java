package com.github.loj.service.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ContestRankDTO;
import com.github.loj.pojo.vo.ContestOutsideInfoVO;

public interface ContestScrollBoardService {

    public CommonResult<IPage> getContestOutsideScoreboard(ContestRankDTO contestRankDTO);

    public CommonResult<ContestOutsideInfoVO> getContestOutsideInfo(Long cid);
}
