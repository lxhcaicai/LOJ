package com.github.loj.validator;

import cn.hutool.core.util.ReUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.contest.ContestRegisterEntityService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestRegister;
import com.github.loj.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.Date;

/**
 * @author lxhcaicai
 * @date 2023/5/8 22:56
 */
@Component
public class ContestValidator {

    @Resource
    private ContestRegisterEntityService contestRegisterEntityService;

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

    public void validateJudgeAuth(Contest contest, String uid) throws StatusForbiddenException {
        if(contest.getAuth().intValue() == Constants.Contest.AUTH_PRIVATE.getCode() ||
                contest.getAuth().intValue() == Constants.Contest.AUTH_PROTECT.getCode()) {
            QueryWrapper<ContestRegister> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("cid", contest.getId()).eq("uid", uid);
            ContestRegister register = contestRegisterEntityService.getOne(queryWrapper, false);
            // 如果还没注册
            if(register == null ){
                throw new StatusForbiddenException("对不起，请你先注册该比赛，提交代码失败！");
            }
        }
    }

    public boolean validateAccountRule(String accountRule, String username) {

        String prefix = ReUtil.get("<prefix>([\\s\\S]*?)</prefix>",
                accountRule, 1);
        String suffix = ReUtil.get("<suffix>([\\s\\S]*?)</suffix>",
                accountRule, 1);
        String start = ReUtil.get("<start>([\\s\\S]*?)</start>",
                accountRule, 1);
        String end = ReUtil.get("<end>([\\s\\S]*?)</end>",
                accountRule, 1);
        String extra = ReUtil.get("<extra>([\\s\\S]*?)</extra>",
                accountRule, 1);

        int startNum = Integer.parseInt(start);
        int endNum = Integer.parseInt(end);

        for(int i = startNum; i <= endNum; i ++) {
            if(username.equals(prefix + i + suffix)) {
                return true;
            }
        }
        // 额外账号列表
        if(!StringUtils.isEmpty(extra)) {
            String[] accountList = extra.trim().split(" ");
            for(String account: accountList) {
                if(username.equals(account)) {
                    return true;
                }
            }
        }
        return false;
    }

}
