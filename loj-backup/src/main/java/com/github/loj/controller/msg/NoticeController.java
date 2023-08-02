package com.github.loj.controller.msg;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.SysMsgVO;
import com.github.loj.service.msg.NoticeService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/api/msg")
public class NoticeController {

    @Resource
    private NoticeService noticeService;

    @GetMapping("/sys")
    @RequiresAuthentication
    public CommonResult<IPage<SysMsgVO>> getSysNotice(@RequestParam(value = "limit",required = false)  Integer limit,
                                                      @RequestParam(value = "currentPage", required = false) Integer currentPage) {
        return noticeService.getSysNotice(limit, currentPage);
    }

    @GetMapping(value = "/mine")
    @RequiresAuthentication
    public CommonResult<IPage<SysMsgVO>> getMineNotice(@RequestParam(value = "limit",required = false)  Integer limit,
                                                       @RequestParam(value = "currentPage", required = false) Integer currentPage) {
        return noticeService.getMineNotice(limit,currentPage);
    }
}
