package com.github.loj.service.msg;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.SysMsgVO;

public interface NoticeService {
    public CommonResult<IPage<SysMsgVO>> getSysNotice(Integer limit, Integer currentPage);
}
