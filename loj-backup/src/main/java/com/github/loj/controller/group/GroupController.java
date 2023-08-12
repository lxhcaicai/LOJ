package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.vo.AccessVO;
import com.github.loj.pojo.vo.GroupVO;
import com.github.loj.service.group.GroupService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class GroupController {

    @Autowired
    private GroupService groupService;

    @GetMapping("/get-group-list")
    @AnonApi
    public CommonResult<IPage<GroupVO>> getGroupList(@RequestParam(value = "limit", required = false) Integer limit,
                                                     @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                     @RequestParam(value = "keyword", required = false) String keyword,
                                                     @RequestParam(value = "auth", required = false) Integer auth,
                                                     @RequestParam(value = "onlyMine", required = false) Boolean onlyMine) {
        return groupService.getGroupList(limit,currentPage, keyword, auth, onlyMine);
    }

    @GetMapping("/get-group-detail")
    @RequiresAuthentication
    public CommonResult<Group> getGroup(@RequestParam(value = "gid", required = true) Long gid) {
        return groupService.getGroup(gid);
    }

    @GetMapping("/get-group-access")
    @RequiresAuthentication
    public CommonResult<AccessVO> getGroupAccess(@RequestParam(value = "gid", required = true) Long gid) {
        return groupService.getGroupAccess(gid);
    }

    @GetMapping("/get-group-auth")
    @RequiresAuthentication
    public CommonResult<Integer> getGroupAuth(@RequestParam(value = "gid", required = true) Long gid) {
        return groupService.getGroupAuth(gid);
    }

    @PostMapping("/group")
    @RequiresAuthentication
    @RequiresPermissions("group_add")
    public CommonResult<Void> addGroup(@RequestBody Group group) {
        return groupService.addGroup(group);
    }
}
