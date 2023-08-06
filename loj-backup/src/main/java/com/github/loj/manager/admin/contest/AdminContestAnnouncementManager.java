package com.github.loj.manager.admin.contest;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.common.AnnouncementEntityService;
import com.github.loj.dao.contest.ContestAnnouncementEntityService;
import com.github.loj.pojo.dto.AnnouncementDTO;
import com.github.loj.pojo.entity.contest.ContestAnnouncement;
import com.github.loj.pojo.vo.AnnouncementVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class AdminContestAnnouncementManager {

    @Autowired
    private AnnouncementEntityService announcementEntityService;

    @Autowired
    private ContestAnnouncementEntityService contestAnnouncementEntityService;


    public IPage<AnnouncementVO> getAnnouncementList(Integer limit, Integer currentPage, Long cid) {

        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }
        return announcementEntityService.getContestAnnouncement(cid, false, limit, currentPage);
    }

    public void deleteAnnouncement(Long aid) throws StatusFailException {
        boolean isOk = announcementEntityService.removeById(aid);
        if(!isOk) {
            throw new StatusFailException("删除失败！");
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public void addAnnouncement(AnnouncementDTO announcementDTO) throws StatusFailException {
        boolean saveAnnouncement = announcementEntityService.save(announcementDTO.getAnnouncement());
        boolean saveContestAnnouncement = contestAnnouncementEntityService.saveOrUpdate(new ContestAnnouncement()
                .setAid(announcementDTO.getAnnouncement().getId())
                .setCid(announcementDTO.getCid()));

        if(!saveAnnouncement || !saveContestAnnouncement) {
            throw new StatusFailException("添加失败");
        }
    }

    public void updateAnnouncement(AnnouncementDTO announcementDTO) throws StatusFailException {
        boolean isOk = announcementEntityService.saveOrUpdate(announcementDTO.getAnnouncement());
        if(!isOk) {
            throw new StatusFailException("更新失败！");
        }
    }
}
