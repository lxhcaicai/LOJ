package com.github.loj.service.oj.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.RankManager;
import com.github.loj.service.oj.RankService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/26 23:52
 */
@Service
public class RankServiceImpl implements RankService {

    @Resource
    private RankManager rankManager;

    @Override
    public CommonResult<IPage> getRankList(Integer limit, Integer currentPage, String searchUser, Integer type) {
        try {
            return CommonResult.successResponse(rankManager.getRankList(limit, currentPage, searchUser, type));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
