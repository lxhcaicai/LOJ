package com.github.loj.service.admin.contest;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.AdminContestVO;

public interface AdminContestService {

    public CommonResult<IPage<Contest>> getContestList(Integer limit, Integer currentPage, String keyword);

    public CommonResult<AdminContestVO> getContest(Long cid);

    public CommonResult<Void> deleteContest(Long cid);

    public CommonResult<Void> addContest(AdminContestVO adminContestVO);

    public CommonResult<Void> updateContest(AdminContestVO adminContestVO);

    public CommonResult<Void> cloneContest(Long cid);

    public CommonResult<Void> changeContestVisible(Long cid, String uid, Boolean visible);

}
