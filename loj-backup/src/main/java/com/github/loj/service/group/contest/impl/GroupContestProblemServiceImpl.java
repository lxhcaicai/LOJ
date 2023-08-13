package com.github.loj.service.group.contest.impl;

import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.group.contest.GroupContestProblemManager;
import com.github.loj.service.group.contest.GroupContestProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class GroupContestProblemServiceImpl implements GroupContestProblemService {

    @Autowired
    private GroupContestProblemManager groupContestProblemManager;

    @Override
    public CommonResult<HashMap<String, Object>> getContestProblemList(Integer limit, Integer currentPage, String keyword, Long cid, Integer problemType, String oj) {
        try {
            return CommonResult.successResponse(groupContestProblemManager.getContestProblemList(limit,currentPage,keyword,cid,problemType,oj));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        } catch (StatusNotFoundException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.NOT_FOUND);
        }
    }
}
