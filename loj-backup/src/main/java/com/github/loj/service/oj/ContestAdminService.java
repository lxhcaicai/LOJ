package com.github.loj.service.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.CheckACDTO;
import com.github.loj.pojo.entity.contest.ContestPrint;
import com.github.loj.pojo.entity.contest.ContestRecord;

public interface ContestAdminService {

    public CommonResult<IPage<ContestRecord>> getContestACInfo(Long cid, Integer currentPage, Integer limit);

    public CommonResult<IPage<ContestPrint>> getContestPrint(Long cid, Integer currentPage, Integer limit);

    public CommonResult<Void> checkContestACInfo(CheckACDTO checkACDTO);
}
