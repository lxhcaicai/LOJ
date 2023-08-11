package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.common.Announcement;
import com.github.loj.pojo.vo.AnnouncementVO;
import com.github.loj.service.group.announcement.GroupAnnouncementService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiresAuthentication
@RequestMapping("/api/group")
public class GroupAnnouncementController {

    @Autowired
    private GroupAnnouncementService groupAnnouncementService;

    @GetMapping("/get-announcement-list")
    public CommonResult<IPage<AnnouncementVO>> getAnnouncementList(@RequestParam(value = "limit", required = false) Integer limit,
                                                                   @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                                   @RequestParam(value = "gid", required = false) Long gid) {
        return groupAnnouncementService.getAnnouncementList(limit, currentPage, gid);
    }

    @GetMapping("/get-admin-announcement-list")
    public CommonResult<IPage<AnnouncementVO>> getAdminAnnouncementList(@RequestParam(value = "limit", required = false) Integer limit,
                                                                   @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                                   @RequestParam(value = "gid", required = false) Long gid) {
        return groupAnnouncementService.getAdminAnnouncementList(limit, currentPage, gid);
    }

    @PostMapping("/announcement")
    public CommonResult<Void> addAnnouncement(@RequestBody Announcement announcement) {
        return groupAnnouncementService.addAnnouncement(announcement);
    }
}
