package com.github.loj.manager.oj;

import com.github.loj.dao.problem.CategoryEntityService;
import com.github.loj.pojo.entity.problem.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/27 23:48
 */
@Component
public class DiscussionManager {

    @Autowired
    private CategoryEntityService categoryEntityService;

    public List<Category> getDiscussionCategory() {
        return categoryEntityService.list();
    }
}
