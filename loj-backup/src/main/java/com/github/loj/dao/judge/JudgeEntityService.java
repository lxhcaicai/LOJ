package com.github.loj.dao.judge;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.vo.JudgeVO;
import com.github.loj.pojo.vo.ProblemCountVO;

import java.util.Date;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 22:12
 */
public interface JudgeEntityService extends IService<Judge> {

    void failToUseRedisPublishJudge(Long submitId, Long pid, Boolean isContest);

    IPage<JudgeVO> getCommonJudgeList(Integer limit,
                                      Integer currentPage,
                                      String searchPid,
                                      Integer status,
                                      String username,
                                      String uid,
                                      Boolean completeProblemID,
                                      Long gid);

    public List<ProblemCountVO> getProblemListCount(List<Long> pidList);

    IPage<JudgeVO> getContestJudgeList(Integer limit,
                                       Integer currentPage,
                                       String displayId,
                                       Long cid,
                                       Integer status,
                                       String username,
                                       String uid,
                                       Boolean beforeContestSubmit,
                                       String rule,
                                       Date startTime,
                                       Date sealRankTime,
                                       String sealTimeUid,
                                       Boolean completeProblemID);

    ProblemCountVO getProblemCount(Long pid, Long gid);

    ProblemCountVO getContestProblemCount(Long pid,
                                          Long cpid,
                                          Long cid,
                                          Date startTime,
                                          Date sealRankTime,
                                          List<String> adminList);
}
