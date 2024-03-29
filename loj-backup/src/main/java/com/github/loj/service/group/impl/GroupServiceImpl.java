package com.github.loj.service.group.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.GroupManager;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.vo.AccessVO;
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

    @Override
    public CommonResult<Group> getGroup(Long gid) {
        try {
            return CommonResult.successResponse(groupManager.getGroup(gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<AccessVO> getGroupAccess(Long gid) {
        try {
            return CommonResult.successResponse(groupManager.getGroupAccess(gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.NOT_FOUND);
        }
    }

    @Override
    public CommonResult<Integer> getGroupAuth(Long gid) {
        return CommonResult.successResponse(groupManager.getGroupAuth(gid));
    }

    @Override
    public CommonResult<Void> addGroup(Group group) {
        try {
            groupManager.addGroup(group);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FAIL);
        }
    }

    @Override
    public CommonResult<Void> updateGroup(Group group) {
        try {
            groupManager.updateGroup(group);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FAIL);
        }
    }

    @Override
    public CommonResult<Void> deleteGroup(Long gid) {
        try {
            groupManager.deleteGroup(gid);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FAIL);
        }
    }
}
