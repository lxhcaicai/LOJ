package com.github.loj.service.oj.impl;

import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.oj.CommentManager;
import com.github.loj.pojo.vo.CommentListVO;
import com.github.loj.service.oj.CommentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.rmi.AccessException;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:08
 */
@Service
public class CommentServiceImpl implements CommentService {

    @Resource
    private CommentManager commentManager;

    @Override
    public CommonResult<CommentListVO> getComments(Long cid, Integer did, Integer limit, Integer currentPage) {
        try {
            return CommonResult.successResponse(commentManager.getComments(cid, did, limit, currentPage));
        } catch (AccessException |  StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.FORBIDDEN);
        }
    }
}
