package com.github.loj.dao.group;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.ContestVO;

public interface GroupContestEntityService extends IService<Contest> {
    IPage<ContestVO> getContestList(Integer limit, Integer currentPage, Long gid);

    IPage<Contest> getAdminContestList(Integer limit, Integer currentPage, Long gid);
}
