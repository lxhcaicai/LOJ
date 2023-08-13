package com.github.loj.service.group.contest;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.AdminContestVO;
import com.github.loj.pojo.vo.ContestVO;

public interface GroupContestService {
    public CommonResult<IPage<ContestVO>> getContestList(Integer limit, Integer currentPage, Long gid);

    public CommonResult<IPage<Contest>> getAdminContestList(Integer limit, Integer currentPage, Long gid);

    public CommonResult<AdminContestVO> getContest(Long cid);

    public CommonResult<Void> addContest(AdminContestVO adminContestVO);

    public CommonResult<Void> updateContest(AdminContestVO adminContestVO);

    public CommonResult<Void> deleteContest(Long cid);

    public CommonResult<Void> changeContestVisible(Long cid, Boolean visible);
}
