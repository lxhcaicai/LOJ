package com.github.loj.manager.admin.contest;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.contest.ContestRegisterEntityService;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestRegister;
import com.github.loj.pojo.vo.AdminContestVO;
import com.github.loj.pojo.vo.ContestAwardConfigVO;
import com.github.loj.pojo.vo.UserRolesVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.ContestValidator;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;

@Component
@Slf4j(topic = "loj")
public class AdminContestManager {

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private ContestValidator contestValidator;

    @Autowired
    private ContestRegisterEntityService contestRegisterEntityService;

    public IPage<Contest> getContestList(Integer limit, Integer currentPage, String keyword) {

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        IPage<Contest> iPage = new Page<>(currentPage, limit);
        QueryWrapper<Contest> queryWrapper = new QueryWrapper<>();
        // 过滤密码
        queryWrapper.select(Contest.class, info -> !info.getColumn().equals("password"));
        if(!StringUtils.isEmpty(keyword)) {
            keyword = keyword.trim();
            queryWrapper
                    .like("title", keyword).or()
                    .like("id", keyword);
        }
        queryWrapper.eq("is_group", false).orderByAsc("start_time");
        return contestEntityService.page(iPage,queryWrapper);
    }

    public AdminContestVO getContest(Long cid) throws StatusFailException, StatusForbiddenException {

        Contest contest = contestEntityService.getById(cid);
        if(contest == null) { // 查询不存在
            throw new StatusFailException("查询失败：该比赛不存在,请检查参数cid是否准确！");
        }
        // 获取当前登录的用户
        UserRolesVO userRolesVO = (UserRolesVO) SecurityUtils.getSubject().getSession().getAttribute("userInfo");

        // 是否为超级管理员
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        // 只有超级管理员和比赛拥有者才能操作
        if(!isRoot && !userRolesVO.getUid().equals(contest.getUid())) {
            throw new StatusForbiddenException("对不起，你无权限操作！");
        }
        AdminContestVO adminContestVO = BeanUtil.copyProperties(contest, AdminContestVO.class, "starAccount");
        if(StringUtils.isEmpty(contest.getStarAccount())) {
            adminContestVO.setStarAccount(new ArrayList<>());
        } else {
            try {
                JSONObject jsonObject = JSONUtil.parseObj(contest.getStarAccount());
                List<String> starAccont = jsonObject.get("star_account", List.class);
                adminContestVO.setStarAccount(starAccont);
            } catch (Exception e) {
                adminContestVO.setStarAccount(new ArrayList<>());
            }
        }

        if(contest.getAwardType() != null && contest.getAwardType() != 0) {
            try {
                JSONObject jsonObject = JSONUtil.parseObj(contest.getAwardConfig());
                List<ContestAwardConfigVO> awardConfigList = jsonObject.get("config",List.class);
                adminContestVO.setAwardConfigList(awardConfigList);
            } catch (Exception e) {
                adminContestVO.setAwardConfigList(new ArrayList<>());
            }
        }
        return adminContestVO;
    }

    public void  deleteContest(Long cid) throws StatusFailException {
        boolean isOk = contestEntityService.removeById(cid);

        if(!isOk) {
            throw new StatusFailException("删除失败");
        }
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        log.info("[{}],[{}],cid:[{}],operatorUid:[{}],operatorUsername:[{}]",
                "Admin_Contest", "Delete", cid, userRolesVo.getUid(), userRolesVo.getUsername());
    }

    public void addContest(AdminContestVO adminContestVO) throws StatusFailException {
        contestValidator.validateContest(adminContestVO);

        Contest contest = BeanUtil.copyProperties(adminContestVO, Contest.class, "starAccount");
        JSONObject accountJson = new JSONObject();
        if(adminContestVO.getSealRank() == null) {
            accountJson.set("star_account", new ArrayList<>());
        } else {
            accountJson.set("star_account", adminContestVO.getStarAccount());
        }
        contest.setStarAccount(accountJson.toString());

        if(adminContestVO.getAwardType() != null && adminContestVO.getAwardType() != 0) {
            JSONObject awardConfigJson = new JSONObject();
            List<ContestAwardConfigVO> awardConfigList = adminContestVO.getAwardConfigList();
            awardConfigList.sort(Comparator.comparing(ContestAwardConfigVO::getPriority));
            awardConfigJson.set("config", awardConfigList);
            contest.setAwardConfig(awardConfigJson.toString());
        }
        boolean isOk = contestEntityService.save(contest);
        if(!isOk) { // 删除失败
            throw new StatusFailException("添加失败");
        }
    }

    public void updateContest(AdminContestVO adminContestVO) throws StatusForbiddenException, StatusFailException {
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 是否为超级管理员
        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        // 只有超级管理员和比赛拥有者才能操作
        if(!isRoot && !userRolesVo.getUid().equals(adminContestVO.getUid())) {
            throw new StatusForbiddenException("对不起，你无权限操作！");
        }

        Contest contest = BeanUtil.copyProperties(adminContestVO,Contest.class, "starAccount");

        JSONObject accountJson = new JSONObject();
        accountJson.set("start_account", adminContestVO.getStarAccount());
        contest.setStarAccount(accountJson.toString());

        if(adminContestVO.getAwardType() != null && adminContestVO.getAwardType() != 0) {
            List<ContestAwardConfigVO> awardConfigList = adminContestVO.getAwardConfigList();
            awardConfigList.sort(Comparator.comparing(ContestAwardConfigVO::getPriority));
            JSONObject awardConfigJson = new JSONObject();
            awardConfigJson.set("config", awardConfigList);
            contest.setAwardConfig(accountJson.toString());
        }

        Contest oldContest = contestEntityService.getById(contest.getId());
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

    public void cloneContest(Long cid) throws StatusSystemErrorException {
        Contest contest = contestEntityService.getById(cid);
        if(contest == null) {
            throw new StatusSystemErrorException("该比赛不存在，无法克隆！");
        }
        // 获取当前登录的用户
        UserRolesVO userRolesVO = (UserRolesVO) SecurityUtils.getSubject().getSession().getAttribute("userInfo");
        contest.setUid(userRolesVO.getUid())
                .setAuthor(userRolesVO.getUsername())
                .setSource(cid.intValue())
                .setId(null)
                .setGmtCreate(null)
                .setGmtModified(null);
        contest.setTitle(contest.getTitle() + "[Cloned]");
        contestEntityService.save(contest);
    }
}
