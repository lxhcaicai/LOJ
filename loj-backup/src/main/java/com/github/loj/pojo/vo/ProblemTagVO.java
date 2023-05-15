package com.github.loj.pojo.vo;

import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.pojo.entity.problem.TagClassification;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/15 21:05
 */
@Data
public class ProblemTagVO implements Serializable {

    /**
     * 标签分类
     */
    private TagClassification classification;

    /**
     * 标签分类
     */
    private List<Tag> tagList;
}
