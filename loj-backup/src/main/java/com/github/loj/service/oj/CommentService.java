package com.github.loj.service.oj;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.CommentListVO;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:08
 */
public interface CommentService {

    public CommonResult<CommentListVO> getComments(Long cid, Integer did, Integer limit, Integer currentPage);
}
