package com.github.loj.pojo.vo;

import com.github.loj.pojo.entity.contest.ContestProblem;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
@ApiModel(value = "赛外排行榜所需的比赛信息，同时包括题目题号、气球颜色", description = "")
public class ContestOutsideInfoVO {

    @ApiModelProperty(value = "比赛信息")
    private ContestVO contest;

    @ApiModelProperty(value = "比赛题目信息列表")
    private List<ContestProblem> problemList;
}
