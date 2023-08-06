package com.github.loj.pojo.dto;

import com.github.loj.pojo.entity.common.Announcement;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class AnnouncementDTO {
    @NotBlank(message = "比赛id不能为空")
    private Long cid;

    private Announcement announcement;
}
