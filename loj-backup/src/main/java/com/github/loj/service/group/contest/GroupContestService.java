package com.github.loj.service.group.contest;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.ContestVO;

public interface GroupContestService {
    public CommonResult<IPage<ContestVO>> getContestList(Integer limit, Integer currentPage, Long gid);

    CommonResult<IPage<Contest>> getAdminContestList(Integer limit, Integer currentPage, Long gid);
}
