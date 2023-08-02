package com.github.loj.service.msg;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.msg.AdminSysNotice;
import com.github.loj.pojo.vo.AdminSysNoticeVO;

public interface AdminNoticeService {
    public CommonResult<IPage<AdminSysNoticeVO>> getSysNotice(Integer limit, Integer currentPage, String type);

    public CommonResult<Void> addSysNotice(AdminSysNotice adminSysNotice);

    public CommonResult<Void> updateSysNotice(AdminSysNotice adminSysNotice);

    public CommonResult<Void> deleteSysNotice(Long id);
}
