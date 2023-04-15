package com.github.loj.judge.entity;

import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author lxhcaicai
 * @date 2023/4/15 18:07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@Builder
public class JudgeDTO {

    private static final long serialVersionUID = 111L;

    /**
     * 当前题目评测点的的编号
     */
    private Integer testCaseNum;

    /**
     * 当前题目评测点的输入文件的名字
     */
    private String testCaseInputFileName;

    /**
     * 当前题目评测点的输入文件的绝对路径
     */
    private String testCaseInputPath;

    /**
     * 当前题目评测点的输入内容
     */
    private String testCaseInputContent;

    /**
     * 当前题目评测点的输出文件的名字
     */
    private String testCaseOutputFileName;

    /**
     * 当前题目评测点的输出文件的绝对路径
     */
    private String testCaseOutputPath;

    /**
     * 当前题目评测点的标准输出内容(目前只用于testJudge)
     */
    private String testCaseOutputContent;

    /**
     * 当前题目评测点的输出字符大小限制 B
     */
    private Long maxOutputSize;

    /**
     * 当前题目评测点的分数（OI题目的测试点才有）
     */
    private Integer score;

    /**
     * problem_case_id
     */
    private Long problemCaseId;
}
