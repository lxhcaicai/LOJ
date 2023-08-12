package com.github.loj.service.group.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.GroupManager;
import com.github.loj.pojo.vo.GroupVO;
import com.github.loj.service.group.GroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GroupServiceImpl implements GroupService {

    @Autowired
    private GroupManager groupManager;

    @Override
    public CommonResult<IPage<GroupVO>> getGroupList(Integer limit, Integer currentPage, String keyword, Integer auth, Boolean onlyMine) {
        return CommonResult.successResponse(groupManager.getGroupList(limit,currentPage,keyword,auth,onlyMine));
    }
}
