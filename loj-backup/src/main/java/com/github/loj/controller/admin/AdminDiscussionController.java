package com.github.loj.controller.admin;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.discussion.Discussion;
import com.github.loj.service.admin.discussion.AdminDiscussionService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin")
public class AdminDiscussionController {
    @Autowired
    private AdminDiscussionService adminDiscussionService;

    @PutMapping("/discussion")
    @RequiresRoles(value = {"root","admin","problem_admin"}, logical = Logical.OR)
    public CommonResult<Void> updateDiscussion(@RequestBody Discussion discussion) {
        return adminDiscussionService.updateDiscussion(discussion);
    }
}
