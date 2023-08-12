package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.service.group.member.GroupMemberService;
import com.github.loj.pojo.vo.GroupMemberVO;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiresAuthentication
@RequestMapping("/api/group")
public class GroupMemberController {

    @Autowired
    private GroupMemberService groupMemberService;

    @GetMapping("/get-member-list")
    public CommonResult<IPage<GroupMemberVO>> getMemberList(@RequestParam(value = "limit", required = false) Integer limit,
                                                            @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                            @RequestParam(value = "keyword", required = false) String keyword,
                                                            @RequestParam(value = "auth", required = false) Integer auth,
                                                            @RequestParam(value = "gid", required = true) Long gid) {
        return groupMemberService.getMemberList(limit,currentPage,keyword,auth,gid);
    }

    @GetMapping("/get-apply-list")
    public CommonResult<IPage<GroupMemberVO>> getApplyList(@RequestParam(value = "limit", required = false) Integer limit,
                                                            @RequestParam(value = "currentPage", required = false) Integer currentPage,
                                                            @RequestParam(value = "keyword", required = false) String keyword,
                                                            @RequestParam(value = "auth", required = false) Integer auth,
                                                            @RequestParam(value = "gid", required = true) Long gid) {
        return groupMemberService.getApplyList(limit,currentPage,keyword,auth,gid);
    }

}
