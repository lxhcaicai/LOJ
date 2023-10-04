package com.github.loj.manager.admin.training;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.dao.training.TrainingEntityService;
import com.github.loj.pojo.entity.training.Training;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;

@Component
@Slf4j(topic = "loj")
public class AdminTrainingManager {

    @Resource
    private TrainingEntityService trainingEntityService;

    public IPage<Training> getTrainingList(Integer limit, Integer currentPage, String keyword) {
        if (currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if (limit == null || limit < 1) {
            limit = 10;
        }
        IPage<Training> iPage = new Page<>(currentPage, limit);
        QueryWrapper<Training> queryWrapper = new QueryWrapper<>();

        // 过滤密码
        queryWrapper.select(Training.class, info -> !info.getColumn().equals("private_pwd"));
        if (!StringUtils.isEmpty(keyword)) {
            keyword = keyword.trim();
            queryWrapper
                    .like("title", keyword).or()
                    .like("id", keyword).or()
                    .like("`rank`", keyword);
        }

        queryWrapper.eq("is_group",false).orderByAsc("`rank`");

        return trainingEntityService.page(iPage, queryWrapper);
    }
}
