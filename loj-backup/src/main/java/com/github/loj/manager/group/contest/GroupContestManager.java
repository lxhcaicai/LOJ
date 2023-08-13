package com.github.loj.manager.group.contest;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestRegisterEntityService;
import com.github.loj.dao.group.GroupContestEntityService;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestRegister;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.vo.AdminContestVO;
import com.github.loj.pojo.vo.ContestAwardConfigVO;
import com.github.loj.pojo.vo.ContestVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.ContestValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;

@Component
public class GroupContestManager {

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private GroupContestEntityService groupContestEntityService;

    @Autowired
    private ContestRegisterEntityService contestRegisterEntityService;

    @Autowired
    private ContestValidator contestValidator;

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

    public void addContest(AdminContestVO adminContestVO) throws StatusFailException, StatusNotFoundException, StatusForbiddenException {

        contestValidator.validateContest(adminContestVO);
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long gid = adminContestVO.getGid();

        if(gid == null) {
            throw new StatusNotFoundException("添加失败，比赛所属的团队ID不可为空！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("添加失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupAdmin(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        Contest contest = BeanUtil.copyProperties(adminContestVO,Contest.class, "starAccount");
        JSONObject accountJson = new JSONObject();
        if(adminContestVO.getStarAccount() == null) {
            accountJson.set("star_account", new ArrayList<>());
        } else {
            accountJson.set("star_account", adminContestVO.getStarAccount());
        }
        contest.setStarAccount(accountJson.toString());

        if(adminContestVO.getAwardType() != null && adminContestVO.getAwardType() != 0) {
            JSONObject awardConfigJson = new JSONObject();
            List<ContestAwardConfigVO> awardConfigList = adminContestVO.getAwardConfigList();
            awardConfigList.sort(Comparator.comparingInt(ContestAwardConfigVO::getPriority));
            awardConfigJson.set("config", awardConfigList);
            contest.setAwardConfig(awardConfigJson.toString());
        }

        contest.setIsGroup(true);

        boolean isOk = contestEntityService.save(contest);
        if(!isOk) {
            throw new StatusFailException("添加失败");
        }

    }

    public void updateContest(AdminContestVO adminContestVO) throws StatusFailException, StatusNotFoundException, StatusForbiddenException {

        contestValidator.validateContest(adminContestVO);

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long cid = adminContestVO.getId();

        if(cid == null) {
            throw new StatusNotFoundException("更新失败，比赛ID不可为空！");
        }

        Contest oldContest = contestEntityService.getById(cid);

        if(oldContest == null) {
            throw new StatusNotFoundException("更新失败，该比赛不存在！");
        }

        Long gid = oldContest.getGid();

        if(gid == null) {
            throw new StatusForbiddenException("更新失败，不可操作非团队内的比赛！");
        }

        Group group = groupEntityService.getById(gid);
        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("更新失败，该团队不存在或已被封禁！");
        }

        if(!userRolesVo.getUid().equals(oldContest.getUid()) && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(),gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        Contest contest = BeanUtil.copyProperties(adminContestVO, Contest.class, "starAccount");
        JSONObject accountJson = new JSONObject();
        accountJson.set("star_account", adminContestVO.getStarAccount());
        contest.setStarAccount(accountJson.toString());

        if(adminContestVO.getAwardType() != null && adminContestVO.getAwardType() != 0) {
            List<ContestAwardConfigVO> awardConfigList = adminContestVO.getAwardConfigList();
            awardConfigList.sort(Comparator.comparingInt(ContestAwardConfigVO::getPriority));
            JSONObject awardConfigJson = new JSONObject();
            awardConfigJson.set("config", awardConfigList);
            contest.setAwardConfig(awardConfigJson.toString());
        }

        boolean isOk = contestEntityService.saveOrUpdate(contest);
        if(isOk) {
            if(!contest.getAuth().equals(Constants.Contest.AUTH_PUBLIC.getCode())) {
                if(!Objects.equals(oldContest.getPwd(), contest.getPwd())) {
                    UpdateWrapper<ContestRegister> updateWrapper = new UpdateWrapper<>();
                    updateWrapper.eq("cid", contest.getId());
                    contestRegisterEntityService.remove(updateWrapper);
                }
            }
        } else {
            throw new StatusFailException("修改失败");
        }
    }

    public void deleteContest(Long cid) throws StatusNotFoundException, StatusForbiddenException, StatusFailException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Contest contest = contestEntityService.getById(cid);

        if(contest == null) {
            throw new StatusNotFoundException("删除失败，该比赛不存在！");
        }

        Long gid = contest.getGid();
        if(gid == null) {
            throw new StatusForbiddenException("删除失败，不可操作非团队内的比赛！");
        }

        Group group = groupEntityService.getById(gid);
        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("删除失败，该团队不存在或已被封禁！");
        }

        if(!userRolesVo.getUid().equals(contest.getUid()) && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        boolean isOk = contestEntityService.removeById(cid);
        if(!isOk) {
            throw new StatusFailException("删除失败");
        }
    }
}
