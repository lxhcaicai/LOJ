package com.github.loj.service.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.ContestPrintDTO;
import com.github.loj.pojo.dto.ContestRankDTO;
import com.github.loj.pojo.dto.RegisterContestDTO;
import com.github.loj.pojo.dto.UserReadContestAnnouncementDTO;
import com.github.loj.pojo.entity.common.Announcement;
import com.github.loj.pojo.vo.*;

import java.util.List;

public interface ContestService {

    public CommonResult<IPage<ContestVO>> getContestList(Integer limit, Integer currentPage, Integer status, Integer type, String keyword);

    public CommonResult<ContestVO> getContestInfo(Long cid);

    public CommonResult<IPage<JudgeVO>> getContestSubmissionList(Integer limit,
                                                                 Integer currentPage,
                                                                 Boolean onlyMine,
                                                                 String displayId,
                                                                 Integer searchStatus,
                                                                 String searchUsername,
                                                                 Long searchCid,
                                                                 Boolean beforeContestSubmit,
                                                                 Boolean completeProblemID);

    public CommonResult<IPage> getContestRank(ContestRankDTO contestRankDTO);

    public CommonResult<IPage<AnnouncementVO>> getContestAnnouncement(Long cid, Integer limit, Integer currentPage);

    public CommonResult<AccessVO> getContestAccess(Long cid);

    public CommonResult<List<ContestProblemVO>> getContestProblem(Long cid);

    public CommonResult<ProblemInfoVO> getContestProblemDetails(Long cid, String displayId);

    public CommonResult<List<Announcement>> getContestUserNotReadAnnouncement(UserReadContestAnnouncementDTO userReadContestAnnouncementDTO);

    public CommonResult<Void> submitPrintText(ContestPrintDTO contestPrintDTO);

    public CommonResult<Void> toRegisterContest(RegisterContestDTO registerContestDTO);
}
