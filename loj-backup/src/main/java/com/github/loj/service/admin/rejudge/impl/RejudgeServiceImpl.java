package com.github.loj.service.admin.rejudge.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.admin.rejudge.RejudgeManager;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.service.admin.rejudge.RejudgeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RejudgeServiceImpl implements RejudgeService {

    @Autowired
    private RejudgeManager rejudgeManager;

    @Override
    public CommonResult<Judge> rejudge(Long submitId) {
        try {
            Judge judge = rejudgeManager.rejudge(submitId);
            return CommonResult.successResponse(judge, "重判成功！该提交已进入判题队列！");
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }
}
