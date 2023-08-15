package com.github.loj.service.group.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.GroupRankManager;
import com.github.loj.pojo.vo.OIRankVO;
import com.github.loj.service.group.GroupRankService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class GroupRankServiceImpl implements GroupRankService {

    @Resource
    private GroupRankManager groupRankManager;

    @Override
    public CommonResult<IPage<OIRankVO>> getGroupRankList(Integer limit, Integer currentPage, String searchUser, Integer type, Long gid) {
        try {
            return CommonResult.successResponse(groupRankManager.getGroupRankList(limit,currentPage,searchUser,type,gid));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
