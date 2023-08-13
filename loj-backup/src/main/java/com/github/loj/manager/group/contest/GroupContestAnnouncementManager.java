package com.github.loj.manager.group.contest;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.common.AnnouncementEntityService;
import com.github.loj.dao.contest.ContestAnnouncementEntityService;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.pojo.dto.AnnouncementDTO;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.contest.ContestAnnouncement;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.vo.AnnouncementVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.CommonValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class GroupContestAnnouncementManager {

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private AnnouncementEntityService announcementEntityService;

    @Autowired
    private CommonValidator commonValidator;

    @Autowired
    private ContestAnnouncementEntityService contestAnnouncementEntityService;


    public IPage<AnnouncementVO> getContestAnnouncementList(Integer limit, Integer currentPage, Long cid) throws StatusNotFoundException, StatusForbiddenException {

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Contest contest = contestEntityService.getById(cid);

        if(contest == null) {
            throw new StatusNotFoundException("获取失败，该比赛不存在！");
        }

        Long gid = contest.getGid();

        if(gid == null) {
            throw new StatusForbiddenException("获取失败，不可获取非团队内的比赛公告！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取失败，该团队不存在或已被封禁！");
        }
        if (!userRolesVo.getUid().equals(contest.getUid()) && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return announcementEntityService.getContestAnnouncement(cid,false,limit,currentPage);
    }

    public void addContestAnnouncement(AnnouncementDTO announcementDto) throws StatusFailException, StatusNotFoundException, StatusForbiddenException {

        commonValidator.validateContent(announcementDto.getAnnouncement().getTitle(), "公告标题", 255);
        commonValidator.validateContentLength(announcementDto.getAnnouncement().getContent(), "公告", 65535);
        commonValidator.validateNotEmpty(announcementDto.getCid(), "比赛ID");

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long cid = announcementDto.getCid();

        Contest contest = contestEntityService.getById(cid);

        if(contest == null) {
            throw new StatusNotFoundException("添加失败，该比赛不存在！");
        }

        Long gid = contest.getGid();
        if(gid == null) {
            throw new StatusForbiddenException("添加失败，不可操作非团队内的比赛公告！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("添加失败，该团队不存在或已被封禁！");
        }
        if (!userRolesVo.getUid().equals(contest.getUid()) && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        announcementDto.getAnnouncement().setGid(gid);
        boolean isOk = announcementEntityService.save(announcementDto.getAnnouncement());
        if(isOk) {
            contestAnnouncementEntityService.saveOrUpdate(new ContestAnnouncement()
                    .setAid(announcementDto.getAnnouncement().getId())
                    .setCid(announcementDto.getCid()));
        } else {
            throw new StatusFailException("添加失败！");
        }
    }
}
