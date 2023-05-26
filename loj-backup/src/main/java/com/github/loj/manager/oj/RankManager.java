package com.github.loj.manager.oj;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.dao.user.UserRecordEntityService;
import com.github.loj.pojo.entity.user.UserInfo;
import com.github.loj.pojo.vo.ACMRankVO;
import com.github.loj.utils.Constants;
import com.github.loj.utils.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/26 23:59
 */
@Component
public class RankManager {

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private UserInfoEntityService userInfoEntityService;

    @Autowired
    private UserRecordEntityService userRecordEntityService;

    // 排行榜缓存时间 60s
    private static final long cacheRankSecond = 60;

    public  IPage getRankList(Integer limit, Integer currentPage, String searchUser, Integer type) throws StatusFailException {
        // 页数，每页题数若为空，设置默认值
        if (currentPage == null || currentPage < 1) currentPage = 1;
        if (limit == null || limit < 1) limit = 30;


        List<String> uidList = null;
        if(!StringUtils.isEmpty(searchUser)) {
            QueryWrapper<UserInfo> userInfoQueryWrapper = new QueryWrapper<>();

            userInfoQueryWrapper.select("uuid");

            userInfoQueryWrapper.and(wrapper -> wrapper
                    .like("username", searchUser)
                    .or()
                    .like("nick", searchUser)
                    .or()
                    .like("realname", searchUser));

            userInfoQueryWrapper.eq("status", 0);

            uidList = userInfoEntityService.list(userInfoQueryWrapper)
                    .stream()
                    .map(UserInfo::getUuid)
                    .collect(Collectors.toList());
        }

        IPage rankList = null;
        // 根据type查询不同类型的排行榜
        if(type.intValue() == Constants.Contest.TYPE_ACM.getCode()) {
            rankList = getACMRankList(limit, currentPage, uidList);
        } else if(type.intValue() == Constants.Contest.TYPE_OI.getCode()) {
            // TODO  OI 排行榜
        } else {
            throw new StatusFailException("排行榜类型代码不正确，请使用0(ACM),1(OI)！");
        }
        return rankList;
    }


    private IPage<ACMRankVO> getACMRankList(int limit, int currentPage, List<String> uidList) {
        IPage<ACMRankVO> data = null;

        if(uidList != null) {
            Page<ACMRankVO> page = new Page<>(currentPage, limit);
            if(uidList.size() > 0) {
                data = userRecordEntityService.getACMRankList(page, uidList);
            } else {
                data = page;
            }
        } else {
            String key = Constants.Account.ACM_RANK_CACHE.getCode() + "_" + limit + "_" + currentPage;
            data = (IPage<ACMRankVO>) redisUtils.get(key);
            if(data == null) {
                Page<ACMRankVO> page = new Page<>(currentPage, limit);
                data = userRecordEntityService.getACMRankList(page, null);
                redisUtils.set(key,data,cacheRankSecond);
            }
        }
        return data;
    }
}
