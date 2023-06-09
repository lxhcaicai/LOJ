package com.github.loj.dao.problem;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ProblemVO;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 0:32
 */
public interface ProblemEntityService extends IService<Problem> {

    Page<ProblemVO> getProblemList(int limit, int currentPage, Long pid, String title,
                                   Integer difficulty, List<Long> tid, String oj);
}
