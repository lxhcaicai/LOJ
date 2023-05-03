package com.github.loj.judge.tesk;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.github.loj.common.exception.SystemError;
import com.github.loj.judge.entity.JudgeDTO;
import com.github.loj.judge.entity.JudgeGlobalDTO;
import com.github.loj.judge.entity.SandBoxRes;
import org.springframework.stereotype.Component;

/**
 * @author lxhcaicai
 * @date 2023/5/2 10:51
 */
@Component
public class InteractiveJudge extends AbstractJudge{
    @Override
    public JSONArray judgeCase(JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO) throws SystemError {
        // TODO
        return null;
    }

    @Override
    public JSONObject checkResult(SandBoxRes sandBoxRes, JudgeDTO judgeDTO, JudgeGlobalDTO judgeGlobalDTO) throws SystemError {
        // TODO
        return null;
    }
}
