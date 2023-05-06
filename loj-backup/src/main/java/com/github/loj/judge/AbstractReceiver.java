package com.github.loj.judge;

/**
 * @author lxhcaicai
 * @date 2023/5/7 1:32
 */
public abstract class AbstractReceiver {

    public void handleWaitingTask(String ...queues) {
        for(String queue: queues) {
            String taskStr = getTaskByRedis(queue);
            if(taskStr != null) {
                handleJudgeMsg(taskStr, queue);
            }
        }
    }

    public abstract String getTaskByRedis(String queue);

    public abstract void handleJudgeMsg(String taskStr, String queueName);

}
