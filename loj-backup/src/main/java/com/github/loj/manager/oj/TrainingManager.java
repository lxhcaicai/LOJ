package com.github.loj.manager.oj;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusAccessDeniedException;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.dao.group.GroupMemberEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.training.*;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.manager.admin.training.AdminTrainingRecordManager;
import com.github.loj.pojo.bo.Pair_;
import com.github.loj.pojo.dto.RegisterTrainingDTO;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.training.*;
import com.github.loj.pojo.vo.*;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.GroupValidator;
import com.github.loj.validator.TrainingValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;
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
    private TrainingRegisterEntityService trainingRegisterEntityService;

    @Resource
    private UserInfoEntityService userInfoEntityService;

    @Resource
    private GroupMemberEntityService groupMemberEntityService;

    @Resource
    private AdminTrainingRecordManager adminTrainingRecordManager;

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


    /**
     * 私有权限的训练需要获取当前用户是否有进入训练的权限
     * @param tid
     * @return
     * @throws StatusFailException
     */
    public AccessVO getTrainingAccess(Long tid) throws StatusFailException {
        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        QueryWrapper<TrainingRegister> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("tid",tid).eq("uid", userRolesVo.getUid());
        TrainingRegister trainingRegister = trainingRegisterEntityService.getOne(queryWrapper,false);
        boolean access = false;
        if(trainingRegister != null) {
            access = true;
            Training training = trainingEntityService.getById(tid);
            if(training == null || !training.getStatus()) {
                throw new StatusFailException("对不起，该训练不存在!");
            }
        }

        AccessVO accessVO = new AccessVO();
        accessVO.setAccess(access);
        return accessVO;
    }

    /**
     * 根据tid获取指定训练的题单题目列表
     * @param tid
     * @return
     * @throws StatusFailException
     * @throws StatusForbiddenException
     * @throws StatusAccessDeniedException
     */
    public List<ProblemVO> getTrainingProblemList(Long tid) throws StatusFailException, StatusForbiddenException, StatusAccessDeniedException {
        Training training = trainingEntityService.getById(tid);
        if(training == null || !training.getStatus()) {
            throw new StatusFailException("该训练不存在或不允许显示！");
        }
        trainingValidator.validateTrainingAuth(training);

        return trainingProblemEntityService.getTrainingProblemList(tid);
    }

    /**
     * 注册校验私有权限的训练
     * @param registerTrainingDTO
     * @throws StatusFailException
     */
    public void toRegisterTraining(RegisterTrainingDTO registerTrainingDTO) throws StatusFailException {

        Long tid = registerTrainingDTO.getTid();
        String password = registerTrainingDTO.getPassword();

        if(tid == null || StringUtils.isEmpty(password)) {
            throw new StatusFailException("请求参数不能为空！");
        }

        Training training = trainingEntityService.getById(tid);

        if(training == null || !training.getStatus()) {
            throw new StatusFailException("对不起，该训练不存在或不允许显示!");
        }

        if(!training.getPrivatePwd().equals(password)) { // 密码不对
            throw new StatusFailException("训练密码错误，请重新输入！");
        }

        // 获取当前登录的用户
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        QueryWrapper<TrainingRegister> registerQueryWrapper = new QueryWrapper<>();
        registerQueryWrapper.eq("tid",tid).eq("uid",userRolesVo.getUid());
        if(trainingRegisterEntityService.count(registerQueryWrapper) > 0) {
            throw new StatusFailException("您已注册过该训练，请勿重复注册！");
        }

        boolean isOk = trainingRegisterEntityService.save(new TrainingRegister()
                .setTid(tid)
                .setUid(userRolesVo.getUid()));

        if(!isOk) {
            throw new StatusFailException("校验训练密码失败，请稍后再试");
        } else {
            adminTrainingRecordManager.syncUserSubmissionToRecordByTid(tid,userRolesVo.getUid());
        }
    }

    /**
     * 获取训练的排行榜分页
     * @param tid
     * @param limit
     * @param currentPage
     * @param keyword
     * @return
     * @throws StatusFailException
     * @throws StatusForbiddenException
     * @throws StatusAccessDeniedException
     */
    public IPage<TrainingRankVO> getTrainingRank(Long tid, Integer limit, Integer currentPage, String keyword) throws StatusFailException, StatusForbiddenException, StatusAccessDeniedException {
        Training training = trainingEntityService.getById(tid);
        if(training == null || !training.getStatus()) {
            throw new StatusFailException("该训练不存在或不允许显示！");
        }

        trainingValidator.validateTrainingAuth(training);

        // 页数，每页数若为空，设置默认值
        if(currentPage == null || currentPage < 1)  {
            currentPage = 1;
        }

        if(limit == null || limit < 1) {
            limit = 30;
        }

        if(StrUtil.isNotBlank(keyword)) {
            keyword = keyword.toLowerCase();
        }

        return getTrainingRank(tid,training.getIsGroup()?training.getGid():null,
                training.getAuthor(),
                currentPage,
                limit,
                keyword);
    }

    private IPage<TrainingRankVO> getTrainingRank(Long tid, Long gid, String username, int currentPage, int limit, String keyword) {

        Map<Long, String> tpIdMapDisplayId = getTPIdMapDisplayId(tid);
        List<TrainingRecordVO> trainingRecordVOList = trainingRecordEntityService.getTrainingRecord(tid);

        List<String> superAdminUidList = userInfoEntityService.getSuperAdminUidList();
        if(gid != null) {
            List<String> groupRootUidList = groupMemberEntityService.getGroupRootUidList(gid);
            superAdminUidList.addAll(groupRootUidList);
        }
        List<TrainingRankVO> result = new ArrayList<>();
        HashMap<String,Integer> uidMapIndex = new HashMap<>();
        int pos = 0;
        for(TrainingRecordVO trainingRecordVO: trainingRecordVOList) {
            // 超级管理员和训练创建者的提交不入排行榜
            if(username.equals(trainingRecordVO.getUsername())
                    || superAdminUidList.contains(trainingRecordVO.getUid())) {
                continue;
            }

            // 如果有搜索关键词则 需要符合模糊匹配 用户名、真实姓名、学校的用户可进行榜单记录
            if(StrUtil.isNotBlank(keyword)) {
                boolean isMatchKeyword = matchKeywordIgnoreCase(keyword,trainingRecordVO.getUsername())
                        || matchKeywordIgnoreCase(keyword, trainingRecordVO.getRealname())
                        || matchKeywordIgnoreCase(keyword, trainingRecordVO.getSchool());
                if(!isMatchKeyword) {
                    continue;
                }
            }

            TrainingRankVO trainingRankVO;
            Integer index = uidMapIndex.get(trainingRecordVO.getUid());
            if(index == null) {
                trainingRankVO = new TrainingRankVO();
                trainingRankVO.setRealname(trainingRankVO.getRealname())
                        .setAvatar(trainingRankVO.getAvatar())
                        .setSchool(trainingRankVO.getSchool())
                        .setGender(trainingRankVO.getGender())
                        .setUid(trainingRankVO.getUid())
                        .setUsername(trainingRankVO.getUsername())
                        .setNickname(trainingRankVO.getNickname())
                        .setAc(0)
                        .setTotalRunTime(0);
                HashMap<String, HashMap<String,Object>> submissionInfo = new HashMap<>();
                trainingRankVO.setSubmissionInfo(submissionInfo);

                result.add(trainingRankVO);
                uidMapIndex.put(trainingRankVO.getUid(), pos);
                pos ++;
            } else {
                trainingRankVO = result.get(index);
            }
            String displayId = tpIdMapDisplayId.get(trainingRecordVO.getTpid());
            HashMap<String,Object> problemSubmissionInfo = trainingRankVO
                    .getSubmissionInfo()
                    .getOrDefault(displayId, new HashMap<>());

            // 如果该题目已经AC过了，只比较运行时间取最小
            if((Boolean) problemSubmissionInfo.getOrDefault("isAc", false)) {
                if(trainingRecordVO.getStatus().intValue() == Constants.Judge.STATUS_ACCEPTED.getStatus()) {
                    int runTime = (int) problemSubmissionInfo.getOrDefault("runTime", 0);
                    if(runTime > trainingRecordVO.getUseTime()) {
                        trainingRankVO.setTotalRunTime(trainingRankVO.getTotalRunTime() - runTime + trainingRecordVO.getUseTime());
                        problemSubmissionInfo.put("runTime", trainingRecordVO.getUseTime());
                    }
                }
                continue;
            }
            problemSubmissionInfo.put("status", trainingRecordVO.getStatus());
            problemSubmissionInfo.put("score", trainingRecordVO.getScore());

            // 通过的话
            if(trainingRecordVO.getStatus().intValue() == Constants.Judge.STATUS_ACCEPTED.getStatus()) {
                // 总解决题目次数ac+1
                trainingRankVO.setAc(trainingRankVO.getAc() + 1);
                problemSubmissionInfo.put("isAC", true);
                problemSubmissionInfo.put("runTime", trainingRecordVO.getUseTime());
                trainingRankVO.setTotalRunTime(trainingRankVO.getTotalRunTime() + trainingRecordVO.getUseTime());
            }

            trainingRankVO.getSubmissionInfo().put(displayId, problemSubmissionInfo);
        }

        List<TrainingRankVO> orderResultList = result.stream().sorted(Comparator.comparing(TrainingRankVO::getAc, Comparator.reverseOrder())
                .thenComparing(TrainingRankVO::getTotalRunTime)).collect(Collectors.toList());

        // 计算好排行榜，然后进行分页
        Page<TrainingRankVO> page = new Page(currentPage, limit);
        int count = orderResultList.size();
        List<TrainingRankVO> pageList = new ArrayList<>();
        //计算当前页第一条数据的下标
        int currId = currentPage > 1 ? (currentPage - 1) * limit : 0;
        for(int i = 0; i < limit && i < count - currId; i ++) {
            pageList.add(orderResultList.get(currId + i));
        }
        page.setSize(limit);
        page.setCurrent(currentPage);
        page.setTotal(count);
        page.setRecords(pageList);
        return page;
    }

    private boolean matchKeywordIgnoreCase(String keyword, String content) {
        return content != null && content.toLowerCase().contains(keyword);
    }

    private Map<Long,String> getTPIdMapDisplayId(Long tid) {
        QueryWrapper<TrainingProblem> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("tid",tid);
        List<TrainingProblem> trainingProblemList = trainingProblemEntityService.list(queryWrapper);
        return trainingProblemList.stream().collect(Collectors.toMap(TrainingProblem::getId, TrainingProblem::getDisplayId));
    }
}
