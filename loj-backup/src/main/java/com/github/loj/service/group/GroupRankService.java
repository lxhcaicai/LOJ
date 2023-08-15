package com.github.loj.service.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.OIRankVO;

public interface GroupRankService {
    public CommonResult<IPage<OIRankVO>> getGroupRankList(Integer limit, Integer currentPage, String searchUser, Integer type, Long gid);
}
