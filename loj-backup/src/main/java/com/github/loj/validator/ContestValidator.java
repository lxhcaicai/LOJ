package com.github.loj.validator;

import com.github.loj.pojo.entity.contest.Contest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * @author lxhcaicai
 * @date 2023/5/8 22:56
 */
@Component
public class ContestValidator {

    @Autowired
    private GroupValidator groupValidator;

    public boolean isSealRank(String uid, Contest contest, Boolean forceRefresh, Boolean isRoot) {
        if(!contest.getSealRank()) {
            return false;
        }
        // 如果是管理员同时选择强制刷新榜单，则封榜无效
        Long gid = contest.getGid();
        boolean isContestAdmin = isRoot || contest.getUid().equals(uid);
        if(forceRefresh && (isContestAdmin || (contest.getIsGroup() && groupValidator.isGroupRoot(uid, gid)))) {
            return false;
        } else if(contest.getSealRank() && contest.getSealRankTime() != null) {
            Date now = new Date();
            // 如果现在时间处于封榜开始到比赛结束之间
            if (now.after(contest.getSealRankTime()) && now.before(contest.getEndTime())) {
                return  true;
            }
            // 或者没有开启赛后自动解除封榜，不可刷新榜单
            return !contest.getAutoRealRank() && now.after(contest.getEndTime());
        }
        return false;
    }

}
