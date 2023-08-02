package com.github.loj.service.msg.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.msg.NoticeManager;
import com.github.loj.pojo.vo.SysMsgVO;
import com.github.loj.service.msg.NoticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Resource
    private NoticeManager noticeManager;
    @Override
    public CommonResult<IPage<SysMsgVO>> getSysNotice(Integer limit, Integer currentPage) {
        return CommonResult.successResponse(noticeManager.getSysNotice(limit, currentPage));
    }
}
