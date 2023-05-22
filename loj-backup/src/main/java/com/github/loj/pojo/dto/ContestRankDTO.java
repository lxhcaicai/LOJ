package com.github.loj.pojo.dto;

import lombok.Data;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/22 23:57
 */
@Data
public class ContestRankDTO {

    private Long cid; // 比赛id

    private Integer limit;

    private Integer currentPage;

    private Boolean forceRefresh;

    private Boolean removeStar; // 是否移除打星队伍

    private String keyword; // 搜索关键词：学校或榜单显示名称

    private List<String> concernedList; // 关注的用户(uuid)列表

    private List<Integer> externalCidList;

}
