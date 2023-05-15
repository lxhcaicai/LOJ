package com.github.loj.manager.oj;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.text.UnicodeUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.config.NacosSwitchConfig;
import com.github.loj.config.SwitchConfig;
import com.github.loj.config.WebConfig;
import com.github.loj.dao.common.AnnouncementEntityService;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.user.UserRecordEntityService;
import com.github.loj.pojo.entity.common.File;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.*;
import com.github.loj.utils.Constants;
import com.github.loj.utils.RedisUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/14 22:51
 */
@Component
public class HomeManager {

    @Autowired
    FileEntityService fileEntityService;

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private UserRecordEntityService userRecordEntityService;

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private NacosSwitchConfig nacosSwitchConfig;

    @Autowired
    private AnnouncementEntityService announcementEntityService;

    @Autowired
    private JudgeEntityService judgeEntityService;

    @Autowired
    private RedisUtils redisUtils;

    private final static String SUBMISSION_STATISTICS_KEY = "home_submission_statistics";

    /**
     * 获取主页轮播图
     * @return
     */
    public List<HashMap<String,Object>> getHomeCarousel() {
        List<File> fileList = fileEntityService.queryCarouselFileList();
        List<HashMap<String,Object>> apiList = fileList.stream().map(f -> {
            HashMap<String,Object> param = new HashMap<>(2);
            param.put("id", f.getId());
            param.put("url", Constants.File.IMG_API.getPath() + f.getName());
            return param;
        }).collect(Collectors.toList());
        return apiList;
    }

    /**
     * 获取最近14天的比赛
     * @return
     */
    public List<ContestVO> getRecentContest() {
        return contestEntityService.getWithinNext14DaysContests();
    }


    /**
     * 获取最近7天用户做题榜单
     * @return
     */
    public List<ACMRankVO> getRecentSevenACRank() {
        return userRecordEntityService.getRecent7ACRank();
    }

    public List<RecentUpdatedProblemVO> getRecentUpdatedProblemList() {

        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();
        problemQueryWrapper.select("id", "problem_id", "title", "type", "gmt_modified", "gmt_create")
                .eq("auth", 1)
                .eq("is_group", false)
                .orderByDesc("gmt_create" )
                .last("limit 10");
        List<Problem> problemList = problemEntityService.list(problemQueryWrapper);
        if( !CollectionUtils.isEmpty(problemList)) {
            return problemList.stream()
                    .map(this::convertUpdatedProblemVO)
                    .collect(Collectors.toList());
        }
        return new ArrayList<>();
    }

    private RecentUpdatedProblemVO convertUpdatedProblemVO(Problem problem) {
        return RecentUpdatedProblemVO.builder()
                .problemId(problem.getProblemId())
                .id(problem.getId())
                .title(problem.getTitle())
                .gmtCreate(problem.getGmtCreate())
                .gmtModified(problem.getGmtModified())
                .type(problem.getType())
                .build();
    }

    /**
     * 获取网站的基础配置。例如名字，缩写名字等等。
     * @return
     */
    public Map<Object,Object> getWebConfig() {
        SwitchConfig switchConfig = nacosSwitchConfig.getSwitchConfig();
        WebConfig webConfig = nacosSwitchConfig.getWebConfig();
        return MapUtil.builder().put("baseUrl", UnicodeUtil.toString(webConfig.getBaseUrl()))
                .put("name", UnicodeUtil.toString(webConfig.getName()))
                .put("shortName", UnicodeUtil.toString(webConfig.getShortName()))
                .put("register", webConfig.getRegister())
                .put("recordName", UnicodeUtil.toString(webConfig.getRecordName()))
                .put("recordUrl", UnicodeUtil.toString(webConfig.getRecordUrl()))
                .put("description", UnicodeUtil.toString(webConfig.getDescription()))
                .put("email", UnicodeUtil.toString(webConfig.getEmailUsername()))
                .put("projectName", UnicodeUtil.toString(webConfig.getProjectName()))
                .put("projectUrl", UnicodeUtil.toString(webConfig.getProjectUrl()))
                .put("openPublicDiscussion", switchConfig.getOpenPublicDiscussion())
                .put("openGroupDiscussion", switchConfig.getOpenGroupDiscussion())
                .put("openContestComment", switchConfig.getOpenContestComment())
                .map();

    }

    /**
     * 获取首页公告列表数
     * @param limit
     * @param currentPage
     * @return
     */
    public IPage<AnnouncementVO> getCommonAnnouncement(Integer limit, Integer currentPage) {
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return announcementEntityService.getAnnouncementList(limit, currentPage, false);
    }

    /**
     * 获取网站最近一周的提交状态（ac总量、提交总量）
     * @param forceRefresh
     * @return
     */
    public SubmissionStatisticsVO getLastWeekSubmissionStatistics(Boolean forceRefresh) {
        SubmissionStatisticsVO submissionStatisticsVO = (SubmissionStatisticsVO) redisUtils.get(SUBMISSION_STATISTICS_KEY);

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        forceRefresh = forceRefresh && isRoot;

        if(submissionStatisticsVO == null || forceRefresh) {
            DateTime dateTime = DateUtil.offsetDay(new Date(), -6);
            String strTime = DateFormatUtils.format(dateTime, "yyyy-MM-dd") + "00:00:00";
            QueryWrapper<Judge> judgeQueryWrapper = new QueryWrapper<>();
            judgeQueryWrapper.select("submit_id", "status", "gmt_create");
            judgeQueryWrapper.apply("UNIX_TIMESTAMP(gmt_create) >= UNIX_TIMESTAMP('" + strTime + "')");
            List<Judge> judgeList = judgeEntityService.list(judgeQueryWrapper);
            submissionStatisticsVO = buildSubmissionStatisticVo(judgeList);
            redisUtils.set(SUBMISSION_STATISTICS_KEY, submissionStatisticsVO, 60 * 30);
        }
        return submissionStatisticsVO;
    }

    private SubmissionStatisticsVO buildSubmissionStatisticVo(List<Judge> judgeList) {
        long acTodayCount = 0;
        long acOneDayAgoCount = 0;
        long acTwoDaysAgoCount = 0;
        long acThreeDaysAgoCount = 0;
        long acFourDaysAgoCount = 0;
        long acFiveDaysAgoCount = 0;
        long acSixDaysAgoCount = 0;

        long totalTodayCount = 0;
        long totalOneDayAgoCount = 0;
        long totalTwoDaysAgoCount = 0;
        long totalThreeDaysAgoCount = 0;
        long totalFourDaysAgoCount = 0;
        long totalFiveDaysAgoCount = 0;
        long totalSixDaysAgoCount = 0;

        Date date = new Date();
        String todayStr = DateUtil.format(date, "MM-dd");
        String oneDayAgoStr = DateFormatUtils.format(DateUtil.offsetDay(date, -1), "MM-dd");
        String twoDaysAgoStr = DateFormatUtils.format(DateUtil.offsetDay(date, -2), "MM-dd");
        String threeDaysAgoStr = DateFormatUtils.format(DateUtil.offsetDay(date, -3), "MM-dd");
        String fourDaysAgoStr = DateFormatUtils.format(DateUtil.offsetDay(date, -4), "MM-dd");
        String fiveDaysAgoStr = DateFormatUtils.format(DateUtil.offsetDay(date, -5), "MM-dd");
        String sixDaysAgoStr = DateFormatUtils.format(DateUtil.offsetDay(date, -6), "MM-dd");

        if(!CollectionUtils.isEmpty(judgeList)) {
            Map<String,List<Judge>> map = judgeList.stream()
                    .collect(
                            Collectors.groupingBy(
                                    o -> DateUtil.format(o.getGmtCreate(), "MM-dd"))
                    );
            for(Map.Entry<String,List<Judge>> entry: map.entrySet()) {
                if(Objects.equals(entry.getKey(), todayStr)) {
                    totalTodayCount += entry.getValue().size();
                    long count = entry.getValue()
                            .parallelStream()
                            .filter(judge -> Objects.equals(judge.getStatus(), Constants.Judge.STATUS_ACCEPTED.getStatus()))
                            .count();
                    acTodayCount += count;
                } else if (Objects.equals(entry.getKey(), oneDayAgoStr)) {
                    totalOneDayAgoCount += entry.getValue().size();
                    long count = entry.getValue()
                            .parallelStream()
                            .filter(judge -> Objects.equals(judge.getStatus(), Constants.Judge.STATUS_ACCEPTED.getStatus()))
                            .count();
                    acOneDayAgoCount += count;
                } else if (Objects.equals(entry.getKey(), twoDaysAgoStr)) {
                    totalTwoDaysAgoCount += entry.getValue().size();
                    long count = entry.getValue()
                            .parallelStream()
                            .filter(judge -> Objects.equals(judge.getStatus(), Constants.Judge.STATUS_ACCEPTED.getStatus()))
                            .count();
                    acTwoDaysAgoCount += count;
                } else if (Objects.equals(entry.getKey(), threeDaysAgoStr)) {
                    totalThreeDaysAgoCount += entry.getValue().size();
                    long count = entry.getValue()
                            .parallelStream()
                            .filter(judge -> Objects.equals(judge.getStatus(), Constants.Judge.STATUS_ACCEPTED.getStatus()))
                            .count();
                    acThreeDaysAgoCount += count;
                } else if (Objects.equals(entry.getKey(), fourDaysAgoStr)) {
                    totalFourDaysAgoCount += entry.getValue().size();
                    long count = entry.getValue()
                            .parallelStream()
                            .filter(judge -> Objects.equals(judge.getStatus(), Constants.Judge.STATUS_ACCEPTED.getStatus()))
                            .count();
                    acFourDaysAgoCount += count;
                } else if (Objects.equals(entry.getKey(), fiveDaysAgoStr)) {
                    totalFiveDaysAgoCount += entry.getValue().size();
                    long count = entry.getValue()
                            .parallelStream()
                            .filter(judge -> Objects.equals(judge.getStatus(), Constants.Judge.STATUS_ACCEPTED.getStatus()))
                            .count();
                    acFiveDaysAgoCount += count;
                } else if (Objects.equals(entry.getKey(), sixDaysAgoStr)) {
                    totalSixDaysAgoCount += entry.getValue().size();
                    long count = entry.getValue()
                            .parallelStream()
                            .filter(judge -> Objects.equals(judge.getStatus(), Constants.Judge.STATUS_ACCEPTED.getStatus()))
                            .count();
                    acSixDaysAgoCount += count;
                }
            }
        }


        SubmissionStatisticsVO submissionStatisticsVO = new SubmissionStatisticsVO();
        submissionStatisticsVO.setDataStrList(Arrays.asList(
                sixDaysAgoStr,
                fiveDaysAgoStr,
                fourDaysAgoStr,
                threeDaysAgoStr,
                twoDaysAgoStr,
                oneDayAgoStr,
                todayStr
        ));

        submissionStatisticsVO.setAcCountList(Arrays.asList(
                acSixDaysAgoCount,
                acFiveDaysAgoCount,
                acFourDaysAgoCount,
                acThreeDaysAgoCount,
                acTwoDaysAgoCount,
                acOneDayAgoCount,
                acTodayCount
        ));

        submissionStatisticsVO.setTotalCountList(Arrays.asList(
                totalSixDaysAgoCount,
                totalFiveDaysAgoCount,
                totalFourDaysAgoCount,
                totalThreeDaysAgoCount,
                totalTwoDaysAgoCount,
                totalOneDayAgoCount,
                totalTodayCount
        ));

        return submissionStatisticsVO;
    }
}
