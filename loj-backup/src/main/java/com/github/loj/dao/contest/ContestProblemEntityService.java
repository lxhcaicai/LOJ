package com.github.loj.dao.contest;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.contest.ContestProblem;
import com.github.loj.pojo.vo.ContestProblemVO;
import com.github.loj.pojo.vo.ProblemFullScreenListVO;

import java.util.Date;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/10 23:41
 */
public interface ContestProblemEntityService extends IService<ContestProblem> {
    List<ProblemFullScreenListVO> getContestFullScreenProblemList(Long cid);

    List<ContestProblemVO> getContestProblemList(Long cid,
                                                 Date startTime,
                                                 Date endTime,
                                                 Date sealTime,
                                                 Boolean isAdmin,
                                                 String contestAuthorUid,
                                                 List<String> groupRootUidList);
}
