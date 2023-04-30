package com.github.loj.remoteJudge.entity;

import com.github.loj.pojo.entity.judge.JudgeCase;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/30 10:40
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@Builder
public class RemoteJudgeRes implements Serializable {

    private static final  long serialVersionUID = 888L;

    private Integer status;

    private Integer time;

    private Integer memory;

    private String errorInfo;

    private List<JudgeCase> judgeCaseList;

}
