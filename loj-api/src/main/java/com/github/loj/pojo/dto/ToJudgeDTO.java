package com.github.loj.pojo.dto;

import com.github.loj.pojo.entity.judge.Judge;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author lxhcaicai
 * @date 2023/4/29 22:27
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class ToJudgeDTO {

    private static final long serialVersion = 888L;

    /**
     *  判题数据实体类
     */
    private Judge judge;

    /**
     *  调用评测验证的token
     */
    private String token;

    /**
     *  远程判题不为空，loj判题为null，例如HDU-1000
     */
    private String remoteJudgeProblem;

    /**
     *  是否为远程判题重判，仅限于已有远程OJ的提交id的重判
     */
    private Boolean isHasSubmitIdRemoteReJudge;

    /**
     *  远程判题所用账号
     */
    private String username;

    /**
     *  远程判题所用密码
     */
    private String password;

    /**
     *  调用判题机的ip
     */
    private String judgeServerIp;

    /**
     *  调用判题机的port
     */
    private Integer judgeServerPort;

    /**
     * VJ判題辅助选择判题机序号使用
     */
    private Integer index;

    private Integer size;
}
