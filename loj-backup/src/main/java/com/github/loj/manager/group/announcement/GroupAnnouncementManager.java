package com.github.loj.manager.group.announcement;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.common.AnnouncementEntityService;
import com.github.loj.dao.group.GroupAnnouncementEntityService;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.pojo.entity.common.Announcement;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.vo.AnnouncementVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.validator.CommonValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class GroupAnnouncementManager {

    @Autowired
    private GroupEntityService groupEntityService;

    @Autowired
    private GroupAnnouncementEntityService groupAnnouncementEntityService;

    @Autowired
    private CommonValidator commonValidator;

    @Autowired
    private AnnouncementEntityService announcementEntityService;

    @Autowired
    private GroupValidator groupValidator;

    public IPage<AnnouncementVO> getAnnouncementList(Integer limit, Integer currentPage, Long gid) throws StatusNotFoundException, StatusForbiddenException {

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);

        if (group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取公告失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupMember(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return groupAnnouncementEntityService.getAnnouncementList(limit,currentPage,gid);
    }

    public IPage<AnnouncementVO> getAdminAnnouncementList(Integer limit, Integer currentPage, Long gid) throws StatusNotFoundException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Group group = groupEntityService.getById(gid);

        if (group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("获取公告失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupMember(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return groupAnnouncementEntityService.getAdminAnnouncementList(limit,currentPage,gid);
    }

    public void addAnnouncement(Announcement announcement) throws StatusFailException, StatusNotFoundException, StatusForbiddenException {

        commonValidator.validateContent(announcement.getTitle(),"公告标题", 255);
        commonValidator.validateContentLength(announcement.getContent(),"公告",65535);
        commonValidator.validateNotEmpty(announcement.getGid(),"团队ID");

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Long gid = announcement.getGid();

        if(gid == null) {
            throw new StatusFailException("添加失败，公告所属团队ID不能为空！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("添加失败，该团队不存在或已被封禁！");
        }

        if(!isRoot && !groupValidator.isGroupAdmin(userRolesVo.getUid(),gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        boolean isOk = announcementEntityService.save(announcement);
        if(!isOk) {
            throw new StatusFailException("添加失败");
        }
    }

    public void updateAnnouncement(Announcement announcement) throws StatusFailException, StatusNotFoundException, StatusForbiddenException {

        commonValidator.validateNotEmpty(announcement.getId(), "公告ID");
        commonValidator.validateContent(announcement.getTitle(),"公告标题", 255);
        commonValidator.validateContentLength(announcement.getContent(),"公告",65535);
        commonValidator.validateNotEmpty(announcement.getGid(),"团队ID");

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Announcement oriAnnouncement = announcementEntityService.getById(announcement.getId());

        if(oriAnnouncement == null) {
            throw new StatusFailException("修改失败，该公告已不存在！");
        }

        Long gid = announcement.getGid();

        if(gid == null) {
            throw new StatusForbiddenException("修改失败，不可操作非团队内的公告！");
        }

        Group group = groupEntityService.getById(gid);

        if(group == null || group.getStatus() == 1 && !isRoot) {
            throw new StatusNotFoundException("修改公告失败，该团队不存在或已被封禁！");
        }

        if(!userRolesVo.getId().equals(oriAnnouncement.getUid())
                && !isRoot
                && !groupValidator.isGroupRoot(userRolesVo.getUid(),gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        boolean isOk = announcementEntityService.updateById(announcement);
        if(!isOk) {
            throw new StatusFailException("修改失败");
        }
    }
}
