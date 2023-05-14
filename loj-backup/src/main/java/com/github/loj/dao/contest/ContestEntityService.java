package com.github.loj.dao.contest;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.ContestVO;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/8 21:02
 */
public interface ContestEntityService extends IService<Contest> {

    List<ContestVO> getWithinNext14DaysContests();
}
