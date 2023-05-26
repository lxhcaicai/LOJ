package com.github.loj.service.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;

/**
 * @author lxhcaicai
 * @date 2023/5/26 23:51
 */
public interface RankService {
    public CommonResult<IPage> getRankList(Integer limit, Integer currentPage, String searchUser, Integer type);
}
