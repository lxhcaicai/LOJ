package com.github.loj.manager.oj;

import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.dao.contest.ContestRecordEntityService;
import com.github.loj.dao.group.GroupMemberEntityService;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.pojo.entity.group.GroupMember;
import com.github.loj.pojo.vo.ACMContestRankVO;
import com.github.loj.pojo.vo.ContestAwardConfigVO;
import com.github.loj.pojo.vo.ContestRecordVO;
import com.github.loj.pojo.vo.OIContestRankVO;
import com.github.loj.utils.Constants;
import com.github.loj.utils.RedisUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/23 0:23
 */
@Component
public class ContestCalculateRankManager {

    @Resource
    private UserInfoEntityService userInfoEntityService;

    @Resource
    private RedisUtils redisUtils;

    @Resource
    private GroupMemberEntityService groupMemberEntityService;

    @Resource
    private ContestRecordEntityService contestRecordEntityService;

    public List<ACMContestRankVO> calcACMRank(boolean isOpenSealRank,
                                              boolean removeStar,
                                              Contest contest,
                                              String currentUserId,
                                              List<String> concernedList,
                                              List<Integer> externalCidList) {
        return calcACMRank(isOpenSealRank,
                removeStar,
                contest,
                currentUserId,
                concernedList,
                externalCidList,
                false,
                null);
    }

    public List<ACMContestRankVO> calcACMRank(Boolean isOpenSealRank,
                                              boolean removeStar,
                                              Contest contest,
                                              String currentUserId,
                                              List<String> concernedList,
                                              List<Integer> externalCidList,
                                              boolean useCache,
                                              Long cacheTime) {
        List<ACMContestRankVO> orderResultList;
        if(useCache) {
            String key = Constants.Contest.CONTEST_RANK_CAL_RESULT_CACHE.getName() + "_" + contest.getId();
            orderResultList = (List<ACMContestRankVO>) redisUtils.get(key);
            if(orderResultList == null) {
                if(isOpenSealRank) {
                    long minSealRankTime = DateUtil.between(contest.getStartTime(), contest.getSealRankTime(), DateUnit.SECOND);
                    orderResultList = getACMOrderRank(contest, true, minSealRankTime, contest.getDuration(), externalCidList);
                } else {
                    orderResultList = getACMOrderRank(contest, false, null, null, externalCidList);
                }
                redisUtils.set(key, orderResultList, cacheTime);
            }
        } else {
            if (isOpenSealRank) {
                long minSealRankTime = DateUtil.between(contest.getStartTime(), contest.getSealRankTime(), DateUnit.SECOND);
                orderResultList = getACMOrderRank(contest, true, minSealRankTime, contest.getDuration(), externalCidList);
            } else {
                orderResultList = getACMOrderRank(contest, false, null, null, externalCidList);
            }
        }

        // 需要打星的用户名列表
        HashMap<String, Boolean> starAccountMap = starAccountToMap(contest.getStarAccount());

        Queue<ContestAwardConfigVO> awardConfigVOList = null;
        boolean isNeedSetAward = contest.getAwardType() != null && contest.getAwardType() > 0;

        if(removeStar) {
            // 如果选择了移除打星队伍，同时该用户属于打星队伍，则将其移除
            orderResultList.removeIf(acmContestRankVO -> starAccountMap.containsKey(acmContestRankVO.getUsername()));
            if(isNeedSetAward) {
                awardConfigVOList = getContestAwardConfigList(contest.getAwardConfig(), contest.getAwardType(), orderResultList.size());
            }
        } else {
            if(isNeedSetAward) {
                if(contest.getAwardType() == 1) {
                    long count = orderResultList.stream().filter(e -> !starAccountMap.containsKey(e.getUsername())).count();
                    awardConfigVOList = getContestAwardConfigList(contest.getAwardConfig(), contest.getAwardType(), (int) count);
                } else {
                    awardConfigVOList = getContestAwardConfigList(contest.getAwardConfig(), contest.getAwardType(), orderResultList.size());
                }
            }
        }

        // 记录当前用户排名数据和关注列表的用户排名数据
        List<ACMContestRankVO> topACMRankVoList = new ArrayList<>();
        boolean needAddConcernedUser = false;
        if(!CollectionUtils.isEmpty(concernedList)) {
            needAddConcernedUser = true;
            // 移除关注列表与当前用户重复
            concernedList.remove(concernedList);
        }

        int rankNum = 1;
        int len = orderResultList.size();
        ACMContestRankVO lastACMRankVo = null;
        ContestAwardConfigVO configVO = null;
        for(int i = 0; i < len; i ++) {
            ACMContestRankVO currentACMRankVo = orderResultList.get(i);
            if(!removeStar && starAccountMap.containsKey(currentACMRankVo.getUsername())) {
                // 打星队伍排名为-1
                currentACMRankVo.setRank(-1);
                currentACMRankVo.setIsWinAward(false);
            } else {
                if(rankNum == 1) {
                    currentACMRankVo.setRank(rankNum);
                } else {
                    // 当前用户的总罚时和AC数跟前一个用户一样的话，同时前一个不应该为打星，排名则一样
                    if(Objects.equals(lastACMRankVo.getAc(), currentACMRankVo.getAc())
                            && lastACMRankVo.getTotalTime().equals(currentACMRankVo.getTotalTime())) {
                        currentACMRankVo.setRank(lastACMRankVo.getRank());
                    } else {
                        currentACMRankVo.setRank(rankNum);
                    }
                }

                if(isNeedSetAward && currentACMRankVo.getAc() > 0) {
                    if(configVO == null || configVO.getNum() == 0) {
                        if(!awardConfigVOList.isEmpty()) {
                            configVO = awardConfigVOList.poll();
                            currentACMRankVo.setAwardName(configVO.getName());
                            currentACMRankVo.setAwardBackground(configVO.getBackground());
                            currentACMRankVo.setAwardColor(configVO.getColor());
                            currentACMRankVo.setIsWinAward(true);
                            configVO.setNum(configVO.getNum() - 1);
                        } else {
                            isNeedSetAward = false;
                            currentACMRankVo.setIsWinAward(false);
                        }
                    } else {
                        currentACMRankVo.setAwardName(configVO.getName());
                        currentACMRankVo.setAwardBackground(configVO.getBackground());
                        currentACMRankVo.setAwardColor(configVO.getColor());
                        currentACMRankVo.setIsWinAward(true);
                        configVO.setNum(configVO.getNum() - 1);
                    }
                } else {
                    currentACMRankVo.setIsWinAward(false);
                }

                lastACMRankVo = currentACMRankVo;
                rankNum ++;

            }
            // 默认将请求用户的排名置为最顶
            if(!StringUtils.isEmpty(currentUserId) &&
                    currentACMRankVo.getUid().equals(currentUserId)) {
                topACMRankVoList.add(0, currentACMRankVo);
            }

            // 需要添加关注用户
            if(needAddConcernedUser) {
                if(concernedList.contains(currentACMRankVo.getUid())) {
                    topACMRankVoList.add(currentACMRankVo);
                }
            }
        }

        topACMRankVoList.addAll(orderResultList);
        return topACMRankVoList;
    }

    private HashMap<String,Boolean> starAccountToMap(String starAccountStr) {
        if(StringUtils.isEmpty(starAccountStr)) {
            return new HashMap<>();
        }
        JSONObject jsonObject = JSONUtil.parseObj(starAccountStr);
        List<String> list = jsonObject.get("star_account", List.class);
        HashMap<String, Boolean> res = new HashMap<>();
        for(String str: list) {
            if(!StringUtils.isEmpty(str)) {
                res.put(str, true);
            }
        }
        return res;
    }

    public List<ACMContestRankVO> getACMOrderRank(Contest contest,
                                                  Boolean isOpenSealRank,
                                                  Long minSealRankTime,
                                                  Long maxSealRankTime,
                                                  List<Integer> externalCidList) {
        List<ContestRecordVO> contestRecordVOList = contestRecordEntityService.getACMContestRecord(contest.getUid(),
                contest.getId(),
                externalCidList,
                contest.getStartTime());

        List<String> superAdminUidList = getSuperAdminUidList(contest.getGid());

        List<ACMContestRankVO> result = new ArrayList<>();

        HashMap<String, Integer> uidMapIndex = new HashMap<>();

        int index = 0;

        HashMap<String, Long> firstACMap = new HashMap<>();
        for(ContestRecordVO contestRecord: contestRecordVOList) {

            if(superAdminUidList.contains(contestRecord.getUid())) { // 超级管理员的提交不入排行榜
                continue;
            }

            ACMContestRankVO acmContestRankVO;
            if(!uidMapIndex.containsKey(contestRecord.getUid())) { // 如果该用户信息没还记录

                // 初始化参数
                acmContestRankVO = new ACMContestRankVO();
                acmContestRankVO.setRealname(contestRecord.getRealname())
                        .setAvatar(contestRecord.getAvatar())
                        .setSchool(contestRecord.getSchool())
                        .setGender(contestRecord.getGender())
                        .setUid(contestRecord.getUid())
                        .setUsername(contestRecord.getUsername())
                        .setNickname((contestRecord.getNickname()))
                        .setAc(0)
                        .setTotalTime(0L)
                        .setTotal(0);

                HashMap<String, HashMap<String, Object>> submissionInfo = new HashMap<>();
                acmContestRankVO.setSubmissionInfo(submissionInfo);

                result.add(acmContestRankVO);
                uidMapIndex.put(contestRecord.getUid(), index);
                index ++;
            } else {
                acmContestRankVO = result.get(uidMapIndex.get(contest.getUid())); // 根据记录的index进行获取
            }

            HashMap<String, Object> problemSubmissionInfo = acmContestRankVO.getSubmissionInfo().get(contestRecord.getDisplayId());

            if(problemSubmissionInfo == null) {
                problemSubmissionInfo = new HashMap<>();
                problemSubmissionInfo.put("errorNum", 0);
            }
            acmContestRankVO.setTotal(acmContestRankVO.getTotal() + 1);

            // 如果是当前是开启封榜的时段和同时该提交是处于封榜时段 尝试次数+1
            if(isOpenSealRank && isInSealTimeSubmission(minSealRankTime, maxSealRankTime, contestRecord.getTime())) {
                int tryNum = (int) problemSubmissionInfo.getOrDefault("tryNum", 0);
                problemSubmissionInfo.put("tryNum", tryNum + 1);
            } else {

                // 如果该题目已经AC过了，其它都不记录了
                if((Boolean) problemSubmissionInfo.getOrDefault("isAc", false)) {
                    continue;
                }

                // 记录已经按题目提交耗时time升序了
                // 通过的话
                if(contestRecord.getStatus().intValue() == Constants.Contest.RECORD_AC.getCode()) {
                    // 总解决题目次数ac+1
                    acmContestRankVO.setAc(acmContestRankVO.getAc() + 1);

                    // 判断是不是first AC
                    boolean isFirstAc = false;
                    Long time = firstACMap.getOrDefault(contestRecord.getDisplayId(), null);
                    if(time == null) {
                        isFirstAc = true;
                        firstACMap.put(contestRecord.getDisplayId(), contestRecord.getTime());
                    } else {
                        // 相同提交时间也是first AC
                        if(time.longValue() == contestRecord.getTime().longValue()) {
                            isFirstAc = true;
                        }
                    }

                    int errorNumber = (int) problemSubmissionInfo.getOrDefault("errorNum", 0);
                    problemSubmissionInfo.put("isAC", true);
                    problemSubmissionInfo.put("isFirstAC", isFirstAc);
                    problemSubmissionInfo.put("ACTime", contestRecord.getTime());
                    problemSubmissionInfo.put("errorNum", errorNumber);

                    // 同时计算总耗时，总耗时加上 该题目未AC前的错误次数*20*60+题目AC耗时
                    acmContestRankVO.setTotalTime(acmContestRankVO.getTotalTime() + errorNumber * 20 * 60 + contestRecord.getTime());

                    // 未通过同时需要记录罚时次数
                } else if (contestRecord.getStatus().intValue() == Constants.Contest.RECORD_NOT_AC_PENALTY.getCode()) {

                    int errorNumber = (int) problemSubmissionInfo.getOrDefault("errorNum", 0);
                    problemSubmissionInfo.put("errorNum", errorNumber + 1);
                } else {

                    int errorNumber = (int) problemSubmissionInfo.getOrDefault("errorNum", 0);
                    problemSubmissionInfo.put("errorNum", errorNumber);
                }
            }
            acmContestRankVO.getSubmissionInfo().put(contestRecord.getDisplayId(), problemSubmissionInfo);
        }

        List<ACMContestRankVO> orderResultList = result.stream().sorted(Comparator.comparing(ACMContestRankVO::getAc, Comparator.reverseOrder()) // 先以总ac数降序
                .thenComparing(ACMContestRankVO::getTotalTime) //再以总耗时升序
        ).collect(Collectors.toList());

        return orderResultList;
    }

    public List<String> getSuperAdminUidList(Long gid) {
        List<String> superAdminUidList = userInfoEntityService.getSuperAdminUidList();

        if(gid != null) {
            QueryWrapper<GroupMember> groupMemberQueryWrapper = new QueryWrapper<>();
            groupMemberQueryWrapper.eq("gid", gid).eq("auth", 5);

            List<GroupMember> groupRootList = groupMemberEntityService.list(groupMemberQueryWrapper);

            for(GroupMember groupMember: groupRootList) {
                superAdminUidList.add(groupMember.getUid());
            }
        }
        return superAdminUidList;
    }

    private boolean isInSealTimeSubmission(Long minSealRankTime, Long maxSealRankTime, Long time) {
        return time >= minSealRankTime && time <= maxSealRankTime;
    }

    private Queue<ContestAwardConfigVO> getContestAwardConfigList(String awardConfig, Integer awardType, Integer totalUser) {
        if(StringUtils.isEmpty(awardConfig)) {
            return new LinkedList<>();
        }
        JSONObject jsonObject = JSONUtil.parseObj(awardConfig);
        List<JSONObject> list = jsonObject.get("config", List.class);

        Queue<ContestAwardConfigVO> queue = new LinkedList<>();

        if(awardType == 1) {
            // 占比转换成具体人数
            for(JSONObject object: list) {
                ContestAwardConfigVO configVO = JSONUtil.toBean(object, ContestAwardConfigVO.class);
                if(configVO.getNum() != null && configVO.getNum() > 0) {
                    int num = (int) (configVO.getNum() * 0.01 * totalUser);
                    if(num > 0) {
                        configVO.setNum(num);
                        queue.offer(configVO);
                    }
                }
            }
        } else {
            for(JSONObject object: list) {
                ContestAwardConfigVO configVO = JSONUtil.toBean(object, ContestAwardConfigVO.class);
                if(configVO.getNum() != null && configVO.getNum() > 0) {
                    queue.offer(configVO);
                }
            }
        }
        return queue;
    }

    /**
     * @param isOpenSealRank  是否是查询封榜后的数据
     * @param removeStar      是否需要移除打星队伍
     * @param contest         比赛实体信息
     * @param currentUserId   当前查看榜单的用户uuid,不为空则将该数据复制一份放置列表最前
     * @param concernedList   关注的用户（uuid）列表
     * @param externalCidList 榜单额外显示比赛列表
     * @param useCache        是否对初始排序计算的结果进行缓存
     * @param cacheTime       缓存的时间 单位秒
     * @MethodName calcOIRank
     * @Return
     */
    public List<OIContestRankVO> calcOIRank(boolean isOpenSealRank,
                                            boolean removeStar,
                                            Contest contest,
                                            String currentUserId,
                                            List<String> concernedList,
                                            List<Integer> externalCidList,
                                            boolean useCache,
                                            Long cacheTime) {

        List<OIContestRankVO>  orderResultList;
        if(useCache) {
            String key = Constants.Contest.CONTEST_RANK_CAL_RESULT_CACHE.getName() + "_" + contest.getId();
            orderResultList = (List<OIContestRankVO>) redisUtils.get(key);
            if(orderResultList == null) {
                orderResultList = getOIOrderRank(contest, externalCidList, isOpenSealRank);
                redisUtils.set(key, orderResultList, cacheTime);
            }
        } else {
            orderResultList = getOIOrderRank(contest, externalCidList, isOpenSealRank);
        }
        // 需要打星的用户名列表
        HashMap<String,Boolean> startAccountMap = starAccountToMap(contest.getStarAccount());

        Queue<ContestAwardConfigVO> awardConfigVoList = null;
        boolean isNeedSetAward = contest.getAwardType() != null && contest.getAwardType() > 0;
        if(removeStar) {
            // 如果选择了移除打星队伍，同时该用户属于打星队伍，则将其移除
            orderResultList.removeIf(acmContestRankVo -> startAccountMap.containsKey(acmContestRankVo.getUsername()));
            if(isNeedSetAward) {
                awardConfigVoList = getContestAwardConfigList(contest.getAwardConfig(), contest.getAwardType(), orderResultList.size());
            }
        } else {
            if(isNeedSetAward) {
                if(contest.getAwardType() == 1) {
                    long count = orderResultList.stream().filter(e -> !startAccountMap.containsKey(e.getUsername())).count();
                    awardConfigVoList = getContestAwardConfigList(contest.getAwardConfig(), contest.getAwardType(), (int) count);
                } else {
                    awardConfigVoList = getContestAwardConfigList(contest.getAwardConfig(), contest.getAwardType(), orderResultList.size());
                }
            }
        }

        // 记录当前用户排名数据和关注列表的用户排名数据
        List<OIContestRankVO> topOIRankVoList = new ArrayList<>();
        boolean needAddConcernedUser = false;
        if(!CollectionUtils.isEmpty(concernedList)) {
            needAddConcernedUser = true;
            // 移除关注列表与当前用户重复
            concernedList.remove(currentUserId);
        }

        int rankNum = 1;
        OIContestRankVO lastOIRankVo = null;
        ContestAwardConfigVO configVO = null;
        int len = orderResultList.size();
        for(int i = 0; i < len; i ++) {
            OIContestRankVO currentOIRankVo = orderResultList.get(i);
            if(!removeStar && startAccountMap.containsKey(currentOIRankVo.getUsername())) {
                // 打星队伍排名为-1
                currentOIRankVo.setRank(-1);
                currentOIRankVo.setIsWinAward(false);
            } else {
                if(rankNum == 1) {
                    currentOIRankVo.setRank(rankNum);
                } else {
                    // 当前用户的程序总运行时间和总得分跟前一个用户一样的话，同时前一个不应该为打星用户，排名则一样
                    if(lastOIRankVo.getTotalScore().equals(currentOIRankVo.getTotalScore())
                            && lastOIRankVo.getTotalTime().equals(currentOIRankVo.getTotalTime())) {
                        currentOIRankVo.setRank(lastOIRankVo.getRank());
                    } else {
                        currentOIRankVo.setRank(rankNum);
                    }
                }

                if(isNeedSetAward && currentOIRankVo.getTotalScore() > 0) {
                    if(concernedList == null || configVO.getNum() == 0) {
                        if(!awardConfigVoList.isEmpty()) {
                            configVO = awardConfigVoList.poll();
                            currentOIRankVo.setAwardName(configVO.getName());
                            currentOIRankVo.setAwardBackground(configVO.getBackground());
                            currentOIRankVo.setAwardColor(configVO.getColor());
                            currentOIRankVo.setIsWinAward(true);
                            configVO.setNum(configVO.getNum() - 1);
                        } else {
                            isNeedSetAward = false;
                            currentOIRankVo.setIsWinAward(false);
                        }
                    } else {
                        currentOIRankVo.setAwardName(configVO.getName());
                        currentOIRankVo.setAwardBackground(configVO.getBackground());
                        currentOIRankVo.setAwardColor(configVO.getColor());
                        currentOIRankVo.setIsWinAward(true);
                        configVO.setNum(configVO.getNum() - 1);
                    }
                } else {
                    currentOIRankVo.setIsWinAward(false);
                }
                lastOIRankVo = currentOIRankVo;
                rankNum ++;
            }
            // 默认当前请求用户的排名显示在最顶行
            if(!StringUtils.isEmpty(currentUserId)
                    && currentOIRankVo.getUid().equals(currentUserId)) {
                topOIRankVoList.add(0, currentOIRankVo);
            }
            // 需要添加关注用户
            if(needAddConcernedUser) {
                if(concernedList.contains(currentOIRankVo.getUid())) {
                    topOIRankVoList.add(currentOIRankVo);
                }
            }
        }
        topOIRankVoList.addAll(orderResultList);
        return topOIRankVoList;
    }

    private List<OIContestRankVO> getOIOrderRank(Contest contest, List<Integer> externalCidList, Boolean isOpenSealRank) {
        List<ContestRecordVO> oiContestRecord = contestRecordEntityService.getOIContestRecord(contest, externalCidList, isOpenSealRank);

        List<String> superAdminUidList = getSuperAdminUidList(contest.getGid());

        List<OIContestRankVO> result = new ArrayList<>();

        HashMap<String,Integer> uidMapIndex = new HashMap<>();

        HashMap<String, HashMap<String, Integer>> uidMapTime = new HashMap<>();

        boolean isHighestRankScore = Constants.Contest.OI_RANK_HIGHEST_SCORE.getCode().equals(contest.getOiRankScoreType());

        int index = 0;

        for(ContestRecordVO contestRecord: oiContestRecord) {

            if(superAdminUidList.contains(contestRecord.getUid())) {
                continue;
            }

            if(contestRecord.getStatus().equals(Constants.Contest.RECORD_AC.getCode())) {
                HashMap<String,Integer> pidMapTime = uidMapTime.get(contestRecord.getUid());
                if(pidMapTime != null) {
                    Integer useTime = pidMapTime.get(contestRecord.getDisplayId());

                    if(useTime != null) {
                        if(useTime > contestRecord.getUseTime()) {
                            pidMapTime.put(contestRecord.getDisplayId(), contestRecord.getUseTime());
                        }
                    } else {
                        pidMapTime.put(contestRecord.getDisplayId(), contestRecord.getUseTime());
                    }
                } else {
                    HashMap<String,Integer> tmp = new HashMap<>();
                    tmp.put(contestRecord.getDisplayId(), contestRecord.getUseTime());
                    uidMapTime.put(contestRecord.getUid(), tmp);
                }
            }

            OIContestRankVO oiContestRankVo;

            if(!uidMapIndex.containsKey(contestRecord.getUid())) {// 如果该用户信息没还记录
                // 初始化参数
                oiContestRankVo = new OIContestRankVO();
                oiContestRankVo.setRealname(contestRecord.getRealname())
                        .setUid(contestRecord.getUid())
                        .setUsername(contestRecord.getUsername())
                        .setSchool(contestRecord.getSchool())
                        .setAvatar(contestRecord.getAvatar())
                        .setGender(contestRecord.getGender())
                        .setNickname(contestRecord.getNickname())
                        .setTotalScore(0);

                HashMap<String,Integer> submissionInfo = new HashMap<>();
                oiContestRankVo.setSubmissionInfo(submissionInfo);

                result.add(oiContestRankVo);
                uidMapIndex.put(contestRecord.getUid(),index);
                index ++;
            } else {
                oiContestRankVo = result.get(uidMapIndex.get(contestRecord.getUid()));// 根据记录的index进行获取
            }

            // 记录总分
            HashMap<String, Integer> submissionInfo = oiContestRankVo.getSubmissionInfo();
            Integer score = submissionInfo.get(contestRecord.getDisplayId());
            if(isHighestRankScore) {
                if(score == null) {
                    oiContestRankVo.setTotalScore(oiContestRankVo.getTotalScore() + contestRecord.getScore());
                    submissionInfo.put(contestRecord.getDisplayId(), contestRecord.getScore());
                }
            } else {
                if(contestRecord.getScore() != null) { // 为了避免同个提交时间的重复计算
                    if(score != null) {
                        oiContestRankVo.setTotalScore(oiContestRankVo.getTotalScore() - score + contestRecord.getScore());
                    } else {
                        oiContestRankVo.setTotalScore(oiContestRankVo.getTotalScore() + contestRecord.getScore());
                    }
                }
                submissionInfo.put(contestRecord.getDisplayId(), contestRecord.getScore());
            }
        }

        for (OIContestRankVO oiContestRankVO: result) {
            HashMap<String, Integer> pidMapTime = uidMapTime.get(oiContestRankVO.getUid());
            int sumTime = 0;
            if(pidMapTime != null) {
                for(String key: pidMapTime.keySet()) {
                    Integer time = pidMapTime.get(key);
                    sumTime += time == null?0:time;
                }
            }
            oiContestRankVO.setTimeInfo(pidMapTime);
            oiContestRankVO.setTotalTime(sumTime);
        }

        // 根据总得分进行降序,再根据总时耗升序排序
        List<OIContestRankVO> orderResultList = result.stream()
                .sorted(Comparator.comparing(OIContestRankVO::getTotalScore, Comparator.reverseOrder())
                        .thenComparing(OIContestRankVO::getTotalTime, Comparator.naturalOrder()))
                .collect(Collectors.toList());
        return orderResultList;
    }

    public List<OIContestRankVO> calcOIRank(Boolean isOpenSealRank,
                                            Boolean removeStar,
                                            Contest contest,
                                            String currentUserId,
                                            List<String> concernedList,
                                            List<Integer> externalCidList) {
        return calcOIRank(isOpenSealRank,
                removeStar,
                contest,
                currentUserId,
                concernedList,
                externalCidList,
                false,
                null);
    }
}
