package com.github.loj.manager.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.pojo.vo.ContestVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @author lxhcaicai
 * @date 2023/5/17 23:01
 */
@Component
public class ContestManager {

    @Autowired
    private ContestEntityService contestEntityService;

    public IPage<ContestVO> getContestList(Integer limit, Integer currentPage, Integer status, Integer type, String keyword) {
        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return contestEntityService.getContestList(limit, currentPage, type, status, keyword);
    }
}
