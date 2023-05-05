package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.vo.ContestScrollBoardSubmissionVO;
import com.github.loj.pojo.vo.JudgeVO;
import com.github.loj.pojo.vo.ProblemCountVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/5 21:13
 */
@Mapper
@Repository
public interface JudgeMapper extends BaseMapper<Judge> {
    IPage<JudgeVO> getCommonJudgeList(Page<JudgeVO> page,
                                      @Param("searchPid") String searchPid,
                                      @Param("status") Integer status,
                                      @Param("username") String username,
                                      @Param("uid") String uid,
                                      @Param("completeProblemID") Boolean completeProblemID,
                                      @Param("gid") Long gid);

    IPage<JudgeVO> getContestJudgeList(Page<JudgeVO> page,
                                       @Param("displayId") String displayId,
                                       @Param("cid") Long cid,
                                       @Param("status") Integer status,
                                       @Param("username") String username,
                                       @Param("uid") String uid,
                                       @Param("beforeContestSubmit") Boolean beforeContestSubmit,
                                       @Param("rule") String rule,
                                       @Param("startTime") Date startTime,
                                       @Param("sealRankTime") Date sealRankTime,
                                       @Param("sealTimeUid") String sealTimeUid,
                                       @Param("completeProblemID") Boolean completeProblemID);

    int getTodayJudgeNum();

    ProblemCountVO getContestProblemCount(@Param("pid") Long pid,
                                          @Param("cpid") Long cpid,
                                          @Param("cid") Long cid,
                                          @Param("startTime") Date startTime,
                                          @Param("sealRankTime") Date sealRankTime,
                                          @Param("adminList") List<String> adminList);

    ProblemCountVO getProblemCount(@Param("pid") Long pid, @Param("gid") Long gid);

    List<ProblemCountVO> getProblemListCount(@Param("pidList") List<Long> pidList);

    List<Judge> getLastYearUserJudgeList(@Param("uid") String uid, @Param("username") String username);

    List<ContestScrollBoardSubmissionVO> getContestScrollBoardSubmission(@Param("cid") Long cid,
                                                                         @Param("uidList") List<String> uidList);
}
