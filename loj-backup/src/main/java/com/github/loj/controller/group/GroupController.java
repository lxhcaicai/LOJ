package com.github.loj.controller.group;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.vo.GroupVO;
import com.github.loj.service.group.GroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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

}
