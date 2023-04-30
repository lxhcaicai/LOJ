package com.github.loj.remoteJudge.task;

import com.github.loj.remoteJudge.task.impl.*;
import com.github.loj.util.Constants;

/**
 * @author lxhcaicai
 * @date 2023/4/30 13:05
 */
public class RemoteJudgeFactory {
    public static RemoteJudgeStrategy selectJudge(String judgeName) {
        Constants.RemoteJudge remoteJudge = Constants.RemoteJudge.getTypeByName(judgeName);
        switch (remoteJudge) {
            case HDU_JUDGE:
                return new HDUJudge();
            case CF_JUDGE:
                return new CodeForcesJudge();
            case POJ_JUDGE:
                return new POJJudge();
            case SPOJ_JUDGE:
                return new SPOJJudge();
            case ATCODER_JUDGE:
                return new AtCoderJudge();
            default:
                return null;
        }
    }
}
