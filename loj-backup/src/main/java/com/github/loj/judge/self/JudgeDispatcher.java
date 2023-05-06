package com.github.loj.judge.self;

import cn.hutool.json.JSONUtil;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.utils.Constants;
import com.github.loj.utils.RedisUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

/**
 * @author lxhcaicai
 * @date 2023/5/7 1:16
 */
@Component
@Slf4j(topic = "loj")
@RefreshScope
public class JudgeDispatcher {

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private JudgeReceiver judgeReceiver;

    @Value("${loj.judge.token}")
    private String judgeToken;

    public void sendTestJudgeTask(TestJudgeReq testJudgeReq) throws StatusSystemErrorException {
        testJudgeReq.setToken(judgeToken);
        try {
            boolean isOk = redisUtils.llPush(Constants.Queue.TEST_JUDGE_WAITING.getName(), JSONUtil.toJsonStr(testJudgeReq));
            if(!isOk) {
                throw new StatusSystemErrorException("系统错误：当前评测任务进入等待队列失败！");
            }
            // 调用判题任务处理
            judgeReceiver.processWaitingTask();
        } catch (Exception e) {
            log.error("调用redis将判题纳入判题等待队列异常--------------->{}", e.getMessage());
            throw new StatusSystemErrorException("系统错误：当前评测任务进入等待队列失败！");
        }
    }
}
