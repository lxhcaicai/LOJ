package com.github.loj.pojo.vo;

import com.github.loj.pojo.entity.judge.JudgeCase;
import lombok.Data;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/8 23:27
 */
@Data
public class JudgeCaseVO {

    /**
     * 当judgeCaseMode为default时
     */
    private List<JudgeCase> judgeCaseList;

    /**
     * 当judgeCaseMode为subtask_lowest,subtask_average时
     */
    private List<SubTaskJudgeCaseVO> subTaskJudgeCaseVoList;

    /**
     * default,subtask_lowest,subtask_average
     */
    private String judgeCaseMode;

}
