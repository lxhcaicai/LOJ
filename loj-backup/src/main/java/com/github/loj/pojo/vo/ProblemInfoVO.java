package com.github.loj.pojo.vo;

import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.problem.Tag;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.HashMap;
import java.util.List;

@Data
@AllArgsConstructor
public class ProblemInfoVO {
    /**
     * 题目内容
     */
    private Problem problem;
    /**
     * 题目标签
     */
    private List<Tag> tags;

    /**
     * 题目可用编程语言
     */
    private List<String> languages;

    /**
     * 题目提交统计情况
     */
    private ProblemCountVO problemCount;

    /**
     * 题目默认模板
     */
    private HashMap<String,String> codeTemplate;
}
