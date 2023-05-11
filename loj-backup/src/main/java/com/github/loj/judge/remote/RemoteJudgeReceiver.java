package com.github.loj.judge.remote;

import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.loj.config.NacosSwitchConfig;
import com.github.loj.config.SwitchConfig;
import com.github.loj.dao.contest.ContestRecordEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.judge.RemoteJudgeAccountEntityService;
import com.github.loj.judge.AbstractReceiver;
import com.github.loj.judge.ChooseUtils;
import com.github.loj.judge.Dispatcher;
import com.github.loj.pojo.dto.ToJudgeDTO;
import com.github.loj.pojo.entity.contest.ContestRecord;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.judge.RemoteJudgeAccount;
import com.github.loj.utils.Constants;
import com.github.loj.utils.RedisUtils;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author lxhcaicai
 * @date 2023/5/11 21:23
 */
@Component
public class RemoteJudgeReceiver extends AbstractReceiver {

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private JudgeEntityService judgeEntityService;

    @Autowired
    private ContestRecordEntityService contestRecordEntityService;

    @Resource
    private ChooseUtils chooseUtils;

    @Autowired
    private RemoteJudgeAccountEntityService remoteJudgeAccountEntityService;

    @Autowired
    private NacosSwitchConfig nacosSwitchConfig;

    @Autowired
    private Dispatcher dispatcher;

    private final static ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(10);

    private final static Map<String,Future> futureTaskMap = new ConcurrentHashMap<>(10);


    @Async("judgeTaskAsyncPool")
    public void processWaitingTask() {
        handleWaitingTask(Constants.Queue.CONTEST_REMOTE_JUDGE_WAITING_HANDLE.getName(),
                Constants.Queue.GENERAL_REMOTE_JUDGE_WAITING_HANDLE.getName());
    }

    @Override
    public String getTaskByRedis(String queue) {
        if(redisUtils.lGetListSize(queue) > 0) {
            return (String) redisUtils.lrPop(queue);
        } else {
            return null;
        }
    }

    @Override
    public void handleJudgeMsg(String taskStr, String queueName) {
        JSONObject task = JSONUtil.parseObj(taskStr);
        String token = task.getStr("token");
        String remoteJudgeProblem = task.getStr("remoteJudgeProblem");
        Boolean isHasSubmitIdRemoteReJudge = task.getBool("isHasSubmitIdRemoteReJudge");
        String remoteOJName = remoteJudgeProblem.split("-")[0].toUpperCase();
        Long judgeId = task.getLong("judgeId");
        Judge judge = judgeEntityService.getById(judgeId);
        if(judge != null) {
            if(Objects.equals(judge.getStatus(),Constants.Judge.STATUS_CANCELLED.getStatus())) {
                if(judge.getCid() != 0 ) {
                    UpdateWrapper<ContestRecord> updateWrapper = new UpdateWrapper<>();
                    // 取消评测，不罚时也不算得分
                    updateWrapper.set("status", Constants.Contest.RECORD_NOT_AC_NOT_PENALTY.getCode());
                    updateWrapper.eq("submit_id", judge.getSubmitId());// submit_id一定只有一个
                    contestRecordEntityService.update(updateWrapper);
                }
            } else {
                dispatchRemoteJudge(judge,
                        token,
                        remoteJudgeProblem,
                        isHasSubmitIdRemoteReJudge,
                        remoteOJName);
            }
        }
    }

    private void dispatchRemoteJudge(Judge judge, String token, String remoteJudgeProblem,
                                     Boolean isHasSubmitIdRemoteReJudge, String remoteOJName) {

        ToJudgeDTO toJudgeDTO = new ToJudgeDTO();
        toJudgeDTO.setJudge(judge)
                .setToken(token)
                .setRemoteJudgeProblem(remoteJudgeProblem);
        Constants.RemoteOJ remoteOJ = Constants.RemoteOJ.getRemoteOJ(remoteOJName);
        if(!checkExistedAccountByOJ(remoteOJ)) {
            judge.setStatus(Constants.Judge.STATUS_SYSTEM_ERROR.getStatus());
            judge.setErrorMessage("System Error! Cause: The System does not have [" + remoteOJ + "] account configured. " +
                    "Please report the matter to the administrator!");
            judgeEntityService.updateById(judge);
        } else {
            if(remoteJudgeProblem.equals(Constants.RemoteOJ.CODEFORCES.getName())
                    || remoteOJName.equals(Constants.RemoteOJ.GYM.getName())) {
                if(ChooseUtils.openCodeforcesFixServer) {
                    fixServerCFJudge(isHasSubmitIdRemoteReJudge,toJudgeDTO,judge);
                } else {
                    commonJudge(Constants.RemoteOJ.CODEFORCES.getName(), isHasSubmitIdRemoteReJudge, toJudgeDTO, judge);
                }
            } else if(remoteOJName.equals(Constants.RemoteOJ.POJ.getName())) {
                pojJudge(isHasSubmitIdRemoteReJudge, toJudgeDTO, judge);
            } else {
                commonJudge(remoteOJName, isHasSubmitIdRemoteReJudge, toJudgeDTO, judge);
            }
        }
        // 如果队列中还有任务，则继续处理
        processWaitingTask();
    }


    private void fixServerCFJudge(Boolean isHasSubmitIdRemoteReJudge, ToJudgeDTO toJudgeDTO, Judge judge) {

        if(isHasSubmitIdRemoteReJudge) {
            toJudgeDTO.setIsHasSubmitIdRemoteReJudge(true);
            toJudgeDTO.setUsername(judge.getVjudgeUsername());
            toJudgeDTO.setPassword(judge.getVjudgePassword());

            // 调用判题服务
            dispatcher.dispatch(Constants.TaskType.REMOTE_JUDGE, toJudgeDTO);
            return;
        }
        // 尝试600s
        String key = UUID.randomUUID().toString() + toJudgeDTO.getJudge().getSubmitId();
        AtomicInteger tryNum = new AtomicInteger(0);
        Runnable getResultTask = new Runnable() {
            @Override
            public void run() {
                if(tryNum.get() > 200) {
                    // 获取调用多次失败可能为系统忙碌，判为提交失败
                    judge.setStatus(Constants.Judge.STATUS_SUBMITTED_FAILED.getStatus());
                    judge.setErrorMessage("Submission failed! Please resubmit this submission again!" +
                            "Cause: Waiting for account scheduling timeout");
                    judgeEntityService.updateById(judge);
                    Future future = futureTaskMap.get(key);
                    if(future != null) {
                        boolean isCanceled = future.cancel(true);
                        if(isCanceled) {
                            futureTaskMap.remove(key);
                        }
                    }
                    return;
                }

                tryNum.getAndIncrement();
                HashMap<String, Object> result = chooseUtils.chooseFixedAccount(Constants.RemoteOJ.CODEFORCES.getName());
                if(result != null) {
                    RemoteJudgeAccount account = (RemoteJudgeAccount) result.get("account");
                    int index= (int) result.get("index");
                    int size = (int) result.get("size");
                    toJudgeDTO.setUsername(account.getUsername())
                            .setPassword(account.getPassword());
                    toJudgeDTO.setIsHasSubmitIdRemoteReJudge(false);
                    toJudgeDTO.setIndex(index);
                    toJudgeDTO.setSize(size);
                    // 调用判题服务
                    dispatcher.dispatch(Constants.TaskType.REMOTE_JUDGE, toJudgeDTO);
                    Future future = futureTaskMap.get(key);
                    if(future != null) {
                        future.cancel(true);
                        futureTaskMap.remove(key);
                    }
                }

            }
        };

        ScheduledFuture<?> scheduledFuture = scheduler.scheduleWithFixedDelay(getResultTask, 0, 3,TimeUnit.SECONDS);
        futureTaskMap.put(key, scheduledFuture);
    }

    private void commonJudge(String OJName, Boolean isHasSubmitIdRemoteJudge, ToJudgeDTO toJudgeDTO, Judge judge) {

        if(isHasSubmitIdRemoteJudge) {
            toJudgeDTO.setIsHasSubmitIdRemoteReJudge(true);
            toJudgeDTO.setUsername(judge.getVjudgeUsername());
            toJudgeDTO.setPassword(judge.getVjudgePassword());
            // 调用判题服务
            dispatcher.dispatch(Constants.TaskType.REMOTE_JUDGE, toJudgeDTO);
            return;
        }

        // 尝试600s
        AtomicInteger tryNum = new AtomicInteger(0);
        String key = UUID.randomUUID().toString() + toJudgeDTO.getJudge().getSubmitId();
        Runnable getResultTask = new Runnable() {
            @Override
            public void run() {
                if(tryNum.get() > 200) {
                    // 获取调用多次失败可能为系统忙碌, 判为提交失败
                    judge.setStatus(Constants.Judge.STATUS_SUBMITTED_FAILED.getStatus());
                    judge.setErrorMessage("Submission failed! Please resubmit this submission again!" +
                            "Cause: Waiting for account scheduling timeout.");
                    judgeEntityService.updateById(judge);
                    Future future = futureTaskMap.get(key);
                    Future future1 = futureTaskMap.get(key);
                    if(future != null) {
                        boolean isCanceled = future.cancel(true);
                        if(isCanceled) {
                            futureTaskMap.remove(key);
                        }
                    }
                    return;
                }
                tryNum.getAndIncrement();
                RemoteJudgeAccount account = chooseUtils.chooseRemoteAccount(OJName, judge.getVjudgeUsername(), false);
                if(account != null) {
                    toJudgeDTO.setUsername(account.getUsername())
                            .setPassword(account.getPassword());
                    toJudgeDTO.setIsHasSubmitIdRemoteReJudge(false);
                    // 调用判题服务
                    Future future = futureTaskMap.get(key);
                    if(future != null) {
                        future.cancel(true);
                        futureTaskMap.remove(key);
                    }
                }
            }
        };
        ScheduledFuture<?> scheduledFuture = scheduler.scheduleWithFixedDelay(getResultTask, 0, 3, TimeUnit.SECONDS);
        futureTaskMap.put(key, scheduledFuture);
    }


    private void pojJudge(Boolean isHasSubmitIdRemoteReJudge, ToJudgeDTO toJudgeDTO, Judge judge) {

        if(StringUtils.isEmpty(judge.getVjudgeUsername())) {
            isHasSubmitIdRemoteReJudge = false;
        }

        if(isHasSubmitIdRemoteReJudge) {
            QueryWrapper<RemoteJudgeAccount> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("oj",Constants.RemoteOJ.POJ.getName())
                    .eq("username", judge.getVjudgeUsername());
            int count = remoteJudgeAccountEntityService.count(queryWrapper);
            if(count == 0) {
                // poj以往的账号丢失了，那么只能重新从头到尾提交
                isHasSubmitIdRemoteReJudge = false;
            }
        }

        // 尝试600s
        AtomicInteger tryNum = new AtomicInteger(0);
        String key = UUID.randomUUID().toString() + toJudgeDTO.getJudge().getSubmitId();
        boolean finalIsHasSubmitIdRemoteReJudge = isHasSubmitIdRemoteReJudge;
        Runnable getResultTask = new Runnable() {
            @Override
            public void run() {
                if(tryNum.get() > 200) {
                    // 获取调用多次失败可能为系统忙碌，判为提交失败
                    judge.setStatus(Constants.Judge.STATUS_SUBMITTED_FAILED.getStatus());
                    judge.setErrorMessage("Submission failed! Please resubmit this submission again!" +
                            "Cause: Waiting for account scheduling timeout");
                    judgeEntityService.updateById(judge);
                    Future future = futureTaskMap.get(key);
                    if(future != null) {
                        boolean isCanceled = future.cancel(true);
                        if(isCanceled) {
                            futureTaskMap.remove(key);
                        }
                    }
                    return;
                }

                tryNum.getAndIncrement();
                RemoteJudgeAccount account = chooseUtils.chooseRemoteAccount(Constants.RemoteOJ.POJ.getName(),
                        judge.getVjudgeUsername(), finalIsHasSubmitIdRemoteReJudge);

                if(account != null) {
                    toJudgeDTO.setUsername(account.getUsername())
                            .setPassword(account.getPassword());
                    toJudgeDTO.setIsHasSubmitIdRemoteReJudge(finalIsHasSubmitIdRemoteReJudge);
                    // 调用判题服务
                    dispatcher.dispatch(Constants.TaskType.REMOTE_JUDGE, toJudgeDTO);
                    Future future = futureTaskMap.get(key);
                    if(future != null) {
                        future.cancel(true);
                        futureTaskMap.remove(key);
                    }
                }
            }
        };

        ScheduledFuture<?> scheduledFuture = scheduler.scheduleWithFixedDelay(getResultTask, 0, 3, TimeUnit.SECONDS);
        futureTaskMap.put(key, scheduledFuture);
    }

    private boolean checkExistedAccountByOJ(Constants.RemoteOJ remoteOJ) {
        if(remoteOJ == null) {
            return  false;
        }
        SwitchConfig switchConfig =  nacosSwitchConfig.getSwitchConfig();
        switch (remoteOJ) {
            case GYM:
            case CODEFORCES:
                return !CollectionUtils.isEmpty(switchConfig.getCfUsernameList());
            case POJ:
                return !CollectionUtils.isEmpty(switchConfig.getPojUsernameList());
            case HDU:
                return !CollectionUtils.isEmpty(switchConfig.getHduUsernameList());
            case SPOJ:
                return !CollectionUtils.isEmpty(switchConfig.getSpojUsernameList());
            case ATCODER:
                return !CollectionUtils.isEmpty(switchConfig.getAtcoderUsernameList());
        }
        return false;
    }
}
