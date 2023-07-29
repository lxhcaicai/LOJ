package com.github.loj.pojo.dto;

import lombok.Data;

import java.util.List;

@Data
public class UserReadContestAnnouncementDTO {
    private Long cid;

    private List<Long> readAnnouncementList;
}
