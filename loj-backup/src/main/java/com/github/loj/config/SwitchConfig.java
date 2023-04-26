package com.github.loj.config;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/27 1:57
 */
@Data
public class SwitchConfig {

    private List<String> hduUsernameList = new ArrayList<>();

    private List<String> hduPasswordList = new ArrayList<>();

    private List<String> cfUsernameList = new ArrayList<>();

    private List<String> cfPasswordList = new ArrayList<>();

    private List<String> pojUsernameList = new ArrayList<>();

    private List<String> pojPasswordList = new ArrayList<>();

    private List<String> atcoderUsernameList = new ArrayList<>();

    private List<String> atcoderPasswordList = new ArrayList<>();

    private List<String> spojUsernameList = new ArrayList<>();

    private List<String> spojPasswordList = new ArrayList<>();

    /**
     * 是否开启公开评论区
     */
    private Boolean openPublicDiscussion = true;

    /**
     * 是否开启团队评论区
     */
    private Boolean openGroupDiscussion = true;

    /**
     * 是否开启比赛讨论区
     */
    private Boolean openContestComment = true;

    /**
     * 是否开启公开评测
     */
    private Boolean openPublicJudge = true;

    /**
     * 是否开启团队评测
     */
    private Boolean openGroupJudge = true;

    /**
     * 是否开启比赛评测
     */
    private Boolean openContestJudge = true;

    /**
     * 是否隐藏非比赛提交详情的代码（超管不受限制）
     */
    private Boolean hideNonContestSubmissionCode = false;

    /**
     * 非比赛的提交间隔秒数
     */
    private Integer defaultSubmitInterval = 8;

    /**
     * 每天可以创建的团队数量
     */
    private Integer defaultCreateGroupDailyLimit = 2;

    /**
     * 总共可以拥有的团队数量
     */
    private Integer defaultCreateGroupLimit = 5;

    /**
     * 创建团队的前提：20道题目通过
     */
    private Integer defaultCreateGroupACInitValue = 20;

    /**
     * 每天可以创建的帖子数量
     */
    private Integer defaultCreateDiscussionDailyLimit = 5;

    /**
     * 创建讨论帖子的前提：10道题目通过
     */
    private Integer defaultCreateDiscussionACInitValue = 10;

    /**
     * 评论和回复的前提：10道题目通过
     */
    private Integer defaultCreateCommentACInitValue = 10;
}
