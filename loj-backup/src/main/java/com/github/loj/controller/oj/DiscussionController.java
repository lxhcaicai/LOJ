package com.github.loj.controller.oj;

import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.problem.Category;
import com.github.loj.service.oj.DiscussionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/27 23:38
 */
@RestController
@RequestMapping("/api")
public class DiscussionController {

    @Autowired
    private DiscussionService discussionService;

    @GetMapping("/discussion-category")
    @AnonApi
    public CommonResult<List<Category>> getDiscussionCategory() {
        return discussionService.getDiscussionCategory();
    }
}
