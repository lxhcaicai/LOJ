package com.github.loj.manager.oj;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/15 21:57
 */
@Component
public class ProblemManager {

    @Autowired
    private ProblemEntityService problemEntityService;

    public Page<ProblemVO> getProblemList(Integer limit, Integer currentPage,
                                          String keyword, List<Long> tagId, Integer difficulty, String oj) {

        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }

        // 关键词查询不为空
        if(!StringUtils.isEmpty(keyword)) {
            keyword = keyword.trim();
        }
        if(oj != null && !Constants.RemoteOJ.isRemoteOJ(oj)) {
            oj = "Mine";
        }
        return problemEntityService.getProblemList(limit, currentPage, null, keyword, difficulty, tagId, oj);
    }

}
