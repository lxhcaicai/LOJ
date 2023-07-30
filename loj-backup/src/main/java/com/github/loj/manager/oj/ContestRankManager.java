package com.github.loj.manager.oj;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.vo.ACMContestRankVO;
import com.github.loj.pojo.vo.OIContestRankVO;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/23 0:12
 */
@Component
public class ContestRankManager {

    @Resource
    private ContestCalculateRankManager contestCalculateRankManager;

    public IPage<ACMContestRankVO> getContestACMRankPage(Boolean isOpenSealRank,
                                                         Boolean removeStar,
                                                         String currentUserId,
                                                         List<String> concernedList,
                                                         List<Integer> externalCidList,
                                                         Contest contest,
                                                         int currentPage,
                                                         int limit,
                                                         String keyword) {
        // 进行排序计算
        List<ACMContestRankVO> orderResultList = contestCalculateRankManager.calcACMRank(isOpenSealRank,
                removeStar,
                contest,
                currentUserId,
                concernedList,
                externalCidList);

        if(StrUtil.isNotBlank(keyword)) {
            String finalKeyword = keyword.trim().toLowerCase();
            orderResultList = orderResultList.stream()
                    .filter(rankVo -> filterBySchoolORRankShowName(finalKeyword,
                            rankVo.getSchool(),
                            getUserRankShowName(contest.getRankShowName(),
                                    rankVo.getUsername(),
                                    rankVo.getRealname(),
                                    rankVo.getNickname())))
                    .collect(Collectors.toList());
        }
        return getPagingRankList(orderResultList, currentPage, limit);
    }

    private Boolean filterBySchoolORRankShowName(String keyword, String school, String rankShowName) {
        if(StrUtil.isNotEmpty(school) && school.toLowerCase().contains(keyword)) {
            return true;
        }
        return StrUtil.isNotEmpty(rankShowName) && rankShowName.toLowerCase().contains(keyword);
    }

    private String getUserRankShowName(String contestRankShowName, String username, String realName, String nickname) {
        switch (contestRankShowName) {
            case "username":
                return username;
            case "realname":
                return realName;
            case "nickname":
                return nickname;
        }
        return null;
    }

    private <T> Page<T> getPagingRankList(List<T> rankList, int currentPage, int limit) {
        Page<T> page = new Page<>(currentPage, limit);
        int count = rankList.size();
        List<T> pageList = new ArrayList<>();
        int currId = currentPage > 1 ? (currentPage - 1) * limit : 0;
        for(int i = 0; i < limit && i < count - currId; i ++) {
            pageList.add(rankList.get(currId + i));
        }

        page.setSize(limit);
        page.setCurrent(currentPage);
        page.setTotal(count);
        page.setRecords(pageList);
        return page;
    }

    /**
     * 获取OI比赛排行榜外榜
     *
     * @param isOpenSealRank  是否开启封榜
     * @param removeStar      是否移除打星队伍
     * @param contest         比赛信息
     * @param currentUserId   当前用户id
     * @param concernedList   关注用户uid列表
     * @param externalCidList 关联比赛id列表
     * @param currentPage     当前页码
     * @param limit           分页大小
     * @param keyword         搜索关键词
     * @param useCache        是否启用缓存
     * @param cacheTime       缓存时间（秒）
     * @return
     */
    public IPage<ACMContestRankVO> getACMContestScoreboard(Boolean isOpenSealRank,
                                                           Boolean removeStar,
                                                           Contest contest,
                                                           String currentUserId,
                                                           List<String> concernedList,
                                                           List<Integer> externalCidList,
                                                           int currentPage,
                                                           int limit,
                                                           String keyword,
                                                           Boolean useCache,
                                                           Long cacheTime) {
        if(CollectionUtil.isNotEmpty(externalCidList)) {
            useCache = false;
        }

        List<ACMContestRankVO> acmContestRankVOS = contestCalculateRankManager.calcACMRank(isOpenSealRank,
                removeStar,
                contest,
                currentUserId,
                concernedList,
                externalCidList,
                useCache,
                cacheTime);

        if(StrUtil.isNotBlank(keyword)) {
            String finalKeyword = keyword.trim().toLowerCase();
            acmContestRankVOS = acmContestRankVOS.stream()
                    .filter(rankVo -> filterBySchoolORRankShowName(finalKeyword,
                            rankVo.getSchool(),
                            getUserRankShowName(contest.getRankShowName(),
                                    rankVo.getUsername(),
                                    rankVo.getRealname(),
                                    rankVo.getNickname())))
                    .collect(Collectors.toList());
        }
        return getPagingRankList(acmContestRankVOS, currentPage, limit);
    }

    public IPage<OIContestRankVO> getOIContestScoreboard(Boolean isOpenSealRank,
                                                           Boolean removeStar,
                                                           Contest contest,
                                                           String currentUserId,
                                                           List<String> concernedList,
                                                           List<Integer> externalCidList,
                                                           int currentPage,
                                                           int limit,
                                                           String keyword,
                                                           Boolean useCache,
                                                           Long cacheTime) {
        if(CollectionUtil.isNotEmpty(externalCidList)) {
            useCache = false;
        }

        List<OIContestRankVO> oiContestRankVOList = contestCalculateRankManager.calcOIRank(isOpenSealRank,
                removeStar,
                contest,
                currentUserId,
                concernedList,
                externalCidList,
                useCache,
                cacheTime);

        if(StrUtil.isNotBlank(keyword)) {
            String finalKeyword = keyword.trim().toLowerCase();
            oiContestRankVOList = oiContestRankVOList.stream()
                    .filter(rankVo -> filterBySchoolORRankShowName(finalKeyword,
                            rankVo.getSchool(),
                            getUserRankShowName(contest.getRankShowName(),
                                    rankVo.getUsername(),
                                    rankVo.getRealname(),
                                    rankVo.getNickname())))
                    .collect(Collectors.toList());
        }
        return getPagingRankList(oiContestRankVOList, currentPage, limit);
    }

}
