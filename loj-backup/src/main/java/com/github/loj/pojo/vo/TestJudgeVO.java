package com.github.loj.pojo.vo;

import lombok.Data;

/**
 * @author lxhcaicai
 * @date 2023/5/7 16:26
 */
@Data
public class TestJudgeVO {

    /**
     * 评测状态码
     */
    private Integer status;

    /**
     * 运行时间 ms
     */
    private Long time;

    /**
     * 运行空间 kb
     */
    private Long memory;

    /**
     * 用户输入
     */
    private String userInput;

    /**
     * 用户输出
     */
    private String userOutput;

    /**
     * 预期输出
     */
    private String expectedOutput;

    /**
     * 错误信息
     */
    private String stderr;

    /**
     * 原题的评测模式：default、spj、interactive
     */
    private String problemJudgeMode;
}
