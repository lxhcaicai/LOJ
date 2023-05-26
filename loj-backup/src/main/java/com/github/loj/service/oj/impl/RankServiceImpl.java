package com.github.loj.service.oj.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.service.oj.RankService;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/26 23:52
 */
@Service
public class RankServiceImpl implements RankService {
    @Override
    public CommonResult<IPage> getRankList(Integer limit, Integer currentPage, String searchUser, Integer type) {
        return null;
    }
}
