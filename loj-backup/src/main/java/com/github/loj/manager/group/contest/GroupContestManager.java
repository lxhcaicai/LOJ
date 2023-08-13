package com.github.loj.manager.group.contest;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.group.GroupContestEntityService;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.vo.AdminContestVO;
import com.github.loj.pojo.vo.ContestAwardConfigVO;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

@Component
public class GroupContestManager {

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private GroupContestEntityService groupContestEntityService;

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private GroupValidator groupValidator;

    public IPage<ContestVO> getContestList(Integer limit, Integer currentPage, Long gid) throws StatusNotFoundException, StatusForbiddenException {

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);

        if(group ==null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取比赛列表失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupMember(userRolesVo.getUid(),gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return groupContestEntityService.getContestList(limit,currentPage,gid);
    }

    public IPage<Contest> getAdminContestList(Integer limit, Integer currentPage, Long gid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);

        if(group ==null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取比赛列表失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupMember(userRolesVo.getUid(),gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return groupContestEntityService.getAdminContestList(limit,currentPage,gid);

    }

    public AdminContestVO getContest(Long cid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Contest contest = contestEntityService.getById(cid);

        if(contest == null) {
            throw new StatusNotFoundException("获取失败，该比赛不存在！");
        }

        Long gid = contest.getGid();
        if(gid == null) {
            throw new StatusForbiddenException("获取比赛失败，不可访问非团队内的比赛！");
        }
        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取比赛失败，该团队不存在或已被封禁！");
        }

        if(!userRolesVo.getUid().equals(contest.getUid()) && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(),gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        AdminContestVO adminContestVO = BeanUtil.copyProperties(contest, AdminContestVO.class, "starAccount");
        if(StringUtils.isEmpty(contest.getStarAccount())) {
            adminContestVO.setStarAccount(new ArrayList<>());
        } else {
            try {
                JSONObject jsonObject = JSONUtil.parseObj(contest.getStarAccount());
                List<String> starAccount = jsonObject.get("star_account", List.class);
                adminContestVO.setStarAccount(starAccount);
            } catch (Exception e) {
                adminContestVO.setStarAccount(new ArrayList<>());
            }
        }

        if(contest.getAwardType() != null && contest.getAwardType() != 0) {
            try {
                JSONObject jsonObject = JSONUtil.parseObj(contest.getAwardConfig());
                List<ContestAwardConfigVO> awardConfigList = jsonObject.get("config", List.class);
                adminContestVO.setAwardConfigList(awardConfigList);
            } catch (Exception e) {
                adminContestVO.setAwardConfigList(new ArrayList<>());
            }
        } else {
            adminContestVO.setAwardConfigList(new ArrayList<>());
        }
        return adminContestVO;
    }
}
