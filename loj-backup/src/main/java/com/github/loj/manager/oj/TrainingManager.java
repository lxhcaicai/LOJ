package com.github.loj.manager.oj;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.exception.StatusAccessDeniedException;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.training.TrainingCategoryEntityService;
import com.github.loj.dao.training.TrainingEntityService;
import com.github.loj.dao.training.TrainingProblemEntityService;
import com.github.loj.dao.training.TrainingRecordEntityService;
import com.github.loj.pojo.bo.Pair_;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.entity.training.TrainingCategory;
import com.github.loj.pojo.entity.training.TrainingProblem;
import com.github.loj.pojo.entity.training.TrainingRecord;
import com.github.loj.pojo.vo.ProblemFullScreenListVO;
import com.github.loj.pojo.vo.TrainingVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.GroupValidator;
import com.github.loj.validator.TrainingValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/7 22:19
 */
@Component
public class TrainingManager {

    @Resource
    private TrainingProblemEntityService trainingProblemEntityService;

    @Resource
    private TrainingRecordEntityService trainingRecordEntityService;

    @Resource
    private TrainingEntityService trainingEntityService;

    @Resource
    private TrainingCategoryEntityService trainingCategoryEntityService;

    @Resource
    private JudgeEntityService judgeEntityService;

    @Resource
    private GroupValidator groupValidator;

    @Resource
    private TrainingValidator trainingValidator;

    /**
     * 未启用，该操作会导致公开训练也记录，但其实并不需要，会造成数据量无效增加
     */
    @Async
    public void checkAndSyncTrainingRecord(Long pid, Long submitId, String uid) {
        List<TrainingProblem> trainingProblemList = trainingProblemEntityService.getPrivateTrainingProblemListByPid(pid,uid);
        if(!CollectionUtils.isEmpty(trainingProblemList)) {
            List<TrainingRecord> trainingRecordList = new ArrayList<>();
            for (TrainingProblem trainingProblem: trainingProblemList) {
                TrainingRecord trainingRecord = new TrainingRecord();
                trainingRecord.setPid(pid)
                        .setTid(trainingProblem.getTid())
                        .setTpid(trainingProblem.getId())
                        .setSubmitId(submitId)
                        .setUid(uid);
                trainingRecordList.add(trainingRecord);
            }
            trainingRecordEntityService.saveBatch(trainingRecordList);
        }
    }

    public IPage<TrainingVO> getTrainingList(Integer limit,
                                             Integer currentPage,
                                             String keyword,
                                             Long categoryId,
                                             String auth) {

        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 20;
        }

        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        String currentUid = null;
        if(userRolesVo != null) {
            currentUid = userRolesVo.getUid();
        }
        return trainingEntityService.getTrainingList(limit, currentPage, categoryId, auth, keyword, currentUid);
    }

    public TrainingVO getTraining(Long tid) throws StatusFailException, StatusForbiddenException, StatusAccessDeniedException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");

        Training training = trainingEntityService.getById(tid);
        if(training == null || !training.getStatus()) {
            throw new StatusFailException("该训练不存在或不允许显示！");
        }

        Long gid = training.getGid();
        if(training.getIsGroup()) {
            if(!isRoot && !groupValidator.isGroupMember(userRolesVo.getUid(), training.getGid())) {
                throw new StatusForbiddenException("对不起，您无权限操作！");
            }
        } else {
            gid = null;
        }

        TrainingVO trainingVO = BeanUtil.copyProperties(training, TrainingVO.class);
        TrainingCategory trainingCategory = trainingCategoryEntityService.getTrainingCategoryByTrainingId(training.getId());
        trainingVO.setCategoryName(trainingCategory.getName())
                .setCategoryColor(trainingCategory.getColor());
        List<Long> trainingProblemIdList = trainingProblemEntityService.getTrainingProblemIdList(training.getId());
        trainingVO.setProblemCount(trainingProblemIdList.size());

        if(userRolesVo != null && trainingValidator.isInTrainingOrAdmin(training, userRolesVo)) {
            Integer count = trainingProblemEntityService.getUserTrainingACProblemCount(userRolesVo.getUid(), gid, trainingProblemIdList);
            trainingVO.setAcCount(count);
        } else {
            trainingVO.setAcCount(0);
        }
        return trainingVO;
    }

    public List<ProblemFullScreenListVO> getProblemFullScreenList(Long tid) throws StatusFailException, StatusForbiddenException, StatusAccessDeniedException {
        Training training = trainingEntityService.getById(tid);
        if(training == null || !training.getStatus()) {
            throw new StatusFailException("该训练不存在或不允许显示！");
        }
        trainingValidator.validateTrainingAuth(training);
        List<ProblemFullScreenListVO> problemList = trainingProblemEntityService.getTrainingFullScreenProblemList(tid);

        List<Long> pidList = problemList.stream().map(ProblemFullScreenListVO::getPid).collect(Collectors.toList());
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        QueryWrapper<Judge> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("distinct pid,status,score,submit_time")
                .in("pid", pidList)
                .eq("uid",userRolesVo.getUid())
                .orderByDesc("submit_time");

        queryWrapper.eq("cid",0);
        if(training.getGid() != null && training.getIsGroup()) {
            queryWrapper.eq("gid", training.getGid());
        } else {
            queryWrapper.isNull("gid");
        }

        List<Judge> judges = judgeEntityService.list(queryWrapper);
        HashMap<Long, Pair_<Integer,Integer>> pidMap = new HashMap<>();
        for(Judge judge: judges) {
            if(Objects.equals(judge.getStatus(), Constants.Judge.STATUS_PENDING.getStatus())
                    || Objects.equals(judge.getStatus(),Constants.Judge.STATUS_COMPILING.getStatus())
                    || Objects.equals(judge.getStatus(),Constants.Judge.STATUS_JUDGING.getStatus())) {
                continue;
            }
            if(judge.getStatus().intValue() == Constants.Judge.STATUS_ACCEPTED.getStatus()) {
                // 如果该题目已通过，则强制写为通过（0）
                pidMap.put(judge.getPid(),new Pair_<>(judge.getStatus(),judge.getScore()));
            } else if(!pidMap.containsKey(judge.getPid())) {
                // 还未写入，则使用最新一次提交的结果
                pidMap.put(judge.getPid(),new Pair_<>(judge.getStatus(),judge.getScore()));
            }
        }
        for(ProblemFullScreenListVO problemVo: problemList) {
            Pair_<Integer, Integer> pair_ = pidMap.get(problemVo.getPid());
            if(pair_ != null) {
                problemVo.setStatus(pair_.getKey());
                problemVo.setScore(pair_.getValue());
            }
        }
        return problemList;
    }
}
