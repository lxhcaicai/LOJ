package com.github.loj.service.msg;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.UserMsgVO;
import com.github.loj.pojo.vo.UserUnreadMsgCountVO;

/**
 * @author lxhcaicai
 * @date 2023/5/14 20:51
 */
public interface UserMessageService {

    public CommonResult<UserUnreadMsgCountVO> getUnreadMsgCount();

    public CommonResult<Void> cleanMsg(String type, Long id);

    public CommonResult<IPage<UserMsgVO>> getCommentMsg(Integer limit, Integer currentPage);

    public CommonResult<IPage<UserMsgVO>> getReplyMsg(Integer limit, Integer currentPage);

}
