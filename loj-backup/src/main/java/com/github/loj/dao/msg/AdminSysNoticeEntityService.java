package com.github.loj.dao.msg;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.msg.AdminSysNotice;
import com.github.loj.pojo.vo.AdminSysNoticeVO;

/**
 * @author lxhcaicai
 * @date 2023/4/24 20:38
 */
public interface AdminSysNoticeEntityService extends IService<AdminSysNotice> {
    public IPage<AdminSysNoticeVO> getSysNotice(int limit, int currentPage, String type);
}
