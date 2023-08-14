package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.LOJAccess;
import com.github.loj.annotation.LOJAccessEnum;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.service.group.discussion.GroupDiscussionService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiresAuthentication
@RequestMapping("/api/group")
@LOJAccess(LOJAccessEnum.GROUP_DISCUSSION)
public class GroupDiscussionController {

    @Autowired
    private GroupDiscussionService groupDiscussionService;

    @GetMapping("/get-discussion-list")
    public CommonResult<IPage<Discussion>> getDiscussionList(@RequestParam(value = "limit", required = false) Integer limit,
                                                             @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                             @RequestParam(value = "gid", required = true) Long gid,
                                                             @RequestParam(value = "pid", required = false) String pid) {
        return groupDiscussionService.getDiscussionList(limit,currentPage,gid,pid);
    }

}
