package com.github.loj.dao.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ProblemVO;

public interface GroupProblemEntityService extends IService<Problem> {
    IPage<ProblemVO> getProblemList(Integer limit, Integer currentPage, Long gid);

    IPage<Problem> getAdminProblemList(Integer limit, Integer currentPage, Long gid);
}
