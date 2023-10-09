package com.github.loj.schedule;

/**
 * @author lxhcaicai
 * @date 2023/5/9 22:08
 */
public interface ScheduleService {
    void deleteAvatar();

    void deleteTestCase();

    void deleteContestPrintText();

    void getOjContestsList();

    void getCodeforcesRating();

    void deleteUserSession();

    void syncNoticeToRecentHalfYearUser();

    void checkUnHandleGroupProblemApplyProgress();

    void check20MPendingSubmission();
}
