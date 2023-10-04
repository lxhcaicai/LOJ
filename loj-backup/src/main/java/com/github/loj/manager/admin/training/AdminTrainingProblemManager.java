package com.github.loj.manager.admin.training;

import cn.hutool.core.io.FileUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.dao.training.TrainingEntityService;
import com.github.loj.dao.training.TrainingProblemEntityService;
import com.github.loj.dao.training.TrainingRecordEntityService;
import com.github.loj.dao.training.TrainingRegisterEntityService;
import com.github.loj.pojo.dto.TrainingProblemDTO;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.entity.training.TrainingProblem;
import com.github.loj.pojo.entity.training.TrainingRecord;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Component
@Slf4j(topic = "loj")
public class AdminTrainingProblemManager {

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private TrainingEntityService trainingEntityService;

    @Autowired
    private JudgeEntityService judgeEntityService;

    @Autowired
    private TrainingRegisterEntityService trainingRegisterEntityService;

    @Autowired
    private TrainingRecordEntityService trainingRecordEntityService;

    @Autowired
    private TrainingProblemEntityService trainingProblemEntityService;

    @Autowired
    private AdminTrainingRecordManager adminTrainingRecordManager;

    public HashMap<String, Object> getProblemList(Integer limit, Integer currentPage, String keyword, Boolean queryExisted, Long tid) {
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }

        IPage<Problem> iPage = new Page<>(currentPage, limit);
        // 根据tid在TrainingProblem表中查询到对应pid集合
        QueryWrapper<TrainingProblem> trainingProblemQueryWrapper = new QueryWrapper<>();
        trainingProblemQueryWrapper.eq("tid",tid).orderByAsc("display_id");
        List<Long> pidList = new LinkedList<>();
        List<TrainingProblem> trainingProblemList = trainingProblemEntityService.list(trainingProblemQueryWrapper);
        HashMap<Long, TrainingProblem> trainingProblemMap = new HashMap<>();
        trainingProblemList.forEach(trainingProblem -> {
            if(!trainingProblemMap.containsKey(trainingProblem.getPid())) {
                trainingProblemMap.put(trainingProblem.getPid(), trainingProblem);
            }
            pidList.add(trainingProblem.getPid());
        });

        HashMap<String,Object> trainingProblem = new HashMap<>();

        QueryWrapper<Problem> problemQueryWrapper = new QueryWrapper<>();

        // 逻辑判断，如果是查询已有的就应该是in，如果是查询不要重复的，使用not in
        if(queryExisted) {
            problemQueryWrapper.in(pidList.size() > 0, "id", pidList);
        } else {
            // 权限需要是公开的（隐藏的，比赛中不可加入！）
            problemQueryWrapper.eq("auth", 1).eq("is_group", false);
            problemQueryWrapper.notIn(pidList.size() > 0, "id", pidList);
        }

        if(!StringUtils.isEmpty(keyword)) {
            problemQueryWrapper.and(wrapper -> wrapper.like("title", keyword).or()
                    .like("problem_id", keyword).or()
                    .like("author", keyword));
        }

        if(pidList.size() == 0 && queryExisted) {
            problemQueryWrapper = new QueryWrapper<>();
            problemQueryWrapper.eq("id", null);
        }

        IPage<Problem> problemListPage = problemEntityService.page(iPage, problemQueryWrapper);

        if(queryExisted && pidList.size() > 0) {
            List<Problem> problemListPageRecords = problemListPage.getRecords();
            List<Problem> sortProblemList = problemListPageRecords
                    .stream()
                    .sorted(Comparator.comparingInt(problem -> trainingProblemMap.get(problem.getId()).getRank()))
                    .collect(Collectors.toList());
            problemListPage.setRecords(sortProblemList);
        }

        trainingProblem.put("problemList", problemListPage);
        trainingProblem.put("trainingProblemMap", trainingProblemMap);

        return trainingProblem;
    }

    @Async
    public void syncAlreadyRegisterUserRecord(Long tid, Long pid, Long tpId) {
        Training training = trainingEntityService.getById(tid);
        if(!Constants.Training.AUTH_PUBLIC.getValue().equals(training.getAuth())) {
            return;
        }
        List<String> uidList = trainingRegisterEntityService.getAlreadyRegisterUidList(tid);
        syncNewProblemUserSubmissionToRecord(pid, tpId, tid, uidList);
    }

    private void syncNewProblemUserSubmissionToRecord(Long pid, Long tpId, Long tid, List<String> uidList) {
        if(!CollectionUtils.isEmpty(uidList)) {
            QueryWrapper<Judge> judgeQueryWrapper = new QueryWrapper<>();
            judgeQueryWrapper.eq("pid", pid)
                    .eq("cid", 0)
                    .eq("status", Constants.Judge.STATUS_ACCEPTED.getStatus())
                    .in("uid", uidList);

            List<Judge> judgeList = judgeEntityService.list(judgeQueryWrapper);
            saveBatchNewRecordByJudgeList(judgeList, tid, tpId, null);
        }
    }

    private void saveBatchNewRecordByJudgeList(List<Judge> judgeList, Long tid, Long tpId,HashMap<Long, Long> pidMapTPid) {
        if(!CollectionUtils.isEmpty(judgeList)) {
            List<TrainingRecord> trainingRecordList = new ArrayList<>();
            for(Judge judge: judgeList) {
                TrainingRecord trainingRecord = new TrainingRecord()
                        .setPid(judge.getPid())
                        .setSubmitId(judge.getSubmitId())
                        .setTid(tid)
                        .setUid(judge.getUid());

                if(pidMapTPid != null) {
                    trainingRecord.setTpid(pidMapTPid.get(judge.getPid()));
                }
                if(tpId != null) {
                    trainingRecord.setTpid(tpId);
                }
                trainingRecordList.add(trainingRecord);
            }
            trainingRecordEntityService.saveBatch(trainingRecordList);
        }
    }

    public void updateProblem(TrainingProblem trainingProblem) throws StatusFailException {
        boolean isOk = trainingProblemEntityService.save(trainingProblem);

        if (!isOk) {
            throw new StatusFailException("修改失败！");
        }
    }

    public void deleteProblem(Long pid, Long tid) throws StatusFailException {
        boolean isOk = false;
        //  训练id不为null，表示就是从比赛列表移除而已
        if (tid != null) {
            QueryWrapper<TrainingProblem> trainingProblemQueryWrapper = new QueryWrapper<>();
            trainingProblemQueryWrapper.eq("tid",tid).eq("pid", pid);
            isOk = trainingProblemEntityService.remove(trainingProblemQueryWrapper);
        } else {

            /*
                problem的id为其他表的外键的表中的对应数据都会被一起删除！
              */
            isOk = problemEntityService.removeById(pid);
        }

        if (isOk) {// 删除成功
            // 获取当前登录的用户
            AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
            if (tid == null) {
                FileUtil.del(Constants.File.TESTCASE_BASE_FOLDER.getPath() + "/" + "problem_" + pid);
                log.info("[{}],[{}],tid:[{}],pid:[{}],operatorUid:[{}],operatorUsername:[{}]",
                        "Admin_Training", "Delete_Problem", tid, pid, userRolesVo.getUid(), userRolesVo.getUsername());
            } else {
                log.info("[{}],[{}],tid:[{}],pid:[{}],operatorUid:[{}],operatorUsername:[{}]",
                        "Admin_Training", "Remove_Problem", tid, pid, userRolesVo.getUid(), userRolesVo.getUsername());
            }
            // 更新训练最近更新时间
            UpdateWrapper<Training> trainingUpdateWrapper = new UpdateWrapper<>();
            trainingUpdateWrapper.set("gmt_modified", new Date())
                    .eq("id", tid);
            trainingEntityService.update(trainingUpdateWrapper);
        } else {
            String msg = "删除失败!";
            if (tid != null) {
                msg = "移除失败！";
            }
            throw new StatusFailException(msg);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public void addProblemFromPublic(TrainingProblemDTO trainingProblemDTO) throws StatusFailException {
        Long pid = trainingProblemDTO.getPid();
        Long tid = trainingProblemDTO.getTid();
        String displayId = trainingProblemDTO.getDisplayId();

        QueryWrapper<TrainingProblem> trainingProblemQueryWrapper = new QueryWrapper<>();
        trainingProblemQueryWrapper.eq("tid",tid)
                .and(wrapper -> wrapper.eq("pid", pid)
                        .or()
                        .eq("display_id", displayId));
        TrainingProblem trainingProblem = trainingProblemEntityService.getOne(trainingProblemQueryWrapper,false);
        if (trainingProblem != null) {
            throw new StatusFailException("添加失败，该题目已添加或者题目的训练展示ID已存在！");
        }

        TrainingProblem newTProblem = new TrainingProblem();
        boolean isOk = trainingProblemEntityService.saveOrUpdate(newTProblem.setTid(tid).setPid(pid).setDisplayId(displayId));
        if (isOk) { // 添加成功
            // 更新训练最近更新时间
            UpdateWrapper<Training> trainingUpdateWrapper = new UpdateWrapper<>();
            trainingUpdateWrapper.set("gmt_modified", new Date())
                    .eq("id",tid);
            trainingEntityService.update(trainingUpdateWrapper);

            // 获取当前登录的用户
            AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
            log.info("[{}],[{}],tid:[{}],pid:[{}],operatorUid:[{}],operatorUsername:[{}]",
                    "Admin_Training", "Add_Public_Problem", tid, pid, userRolesVo.getUid(), userRolesVo.getUsername());

            // 异步地同步用户对该题目的提交数据
            adminTrainingRecordManager.syncAlreadyRegisterUserRecord(tid, pid, newTProblem.getId());
        } else {
            throw new StatusFailException("添加失败！");
        }
    }
}
