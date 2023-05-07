package com.github.loj.pojo.vo;

import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/5/7 22:39
 */
@Data
public class ProblemFullScreenListVO {

    private Long pid;

    private String problemId;

    private String title;

    private Integer status;

    private Integer score;
}
