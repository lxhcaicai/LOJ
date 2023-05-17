package com.github.loj.service.oj.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.oj.ContestManager;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.service.oj.ContestService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/5/17 22:59
 */
@Service
public class ContestServiceImpl implements ContestService {

    @Resource
    private ContestManager contestManager;
    @Override
    public CommonResult<IPage<ContestVO>> getContestList(Integer limit, Integer currentPage, Integer status, Integer type, String keyword) {
        return CommonResult.successResponse(contestManager.getContestList(limit, currentPage, status, type, keyword));
    }

    @Override
    public CommonResult<ContestVO> getContestInfo(Long cid) {
        try {
            return CommonResult.successResponse(contestManager.getContestInfo(cid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
