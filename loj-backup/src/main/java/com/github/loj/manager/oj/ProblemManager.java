package com.github.loj.manager.oj;

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.pojo.dto.PidListDTO;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.pojo.vo.RandomProblemVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.ContestValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

/**
 * @author lxhcaicai
 * @date 2023/5/15 21:57
 */
@Component
public class ProblemManager {

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private JudgeEntityService judgeEntityService;

    @Autowired
    private ContestEntityService contestEntityService;

    @Autowired
    private ContestValidator contestValidator;

    public Page<ProblemVO> getProblemList(Integer limit, Integer currentPage,
                                          String keyword, List<Long> tagId, Integer difficulty, String oj) {

        // 页数，每页题数若为空，设置默认值
        if(currentPage == null || currentPage < 1) {
            currentPage = 1;
        }
        if(limit == null || limit < 1) {
            limit = 10;
        }

        // 关键词查询不为空
        if(!StringUtils.isEmpty(keyword)) {
            keyword = keyword.trim();
        }
        if(oj != null && !Constants.RemoteOJ.isRemoteOJ(oj)) {
            oj = "Mine";
        }
        return problemEntityService.getProblemList(limit, currentPage, null, keyword, difficulty, tagId, oj);
    }

    /**
     * 获取用户对应该题目列表中各个题目的做题情况
     * @param pidListDTO
     * @return
     */
    public HashMap<Long,Object> getUserProblemStatus(PidListDTO pidListDTO) throws StatusNotFoundException {
        // 需要获取一下该token对应用户的数据
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        HashMap<Long,Object> result = new HashMap<>();
        // 先查询判断该用户对于这些题是否已经通过，若已通过，则无论后续再提交结果如何，该题都标记为通过
        QueryWrapper<Judge> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("distinct pid,status,submit_time,score")
                .in("pid", pidListDTO.getPidList())
                .eq("uid", userRolesVo.getUid())
                .orderByDesc("submit_time");

        if(pidListDTO.getIsContestProblemList()) {
            // 如果是比赛的提交记录需要判断cid
            queryWrapper.eq("cid", pidListDTO.getCid());
        } else {
            queryWrapper.eq("cid", 0);
            if(pidListDTO.getGid() != null) {
                queryWrapper.eq("gid", pidListDTO.getGid());
            } else {
                queryWrapper.isNull("gid");
            }
        }
        List<Judge> judges = judgeEntityService.list(queryWrapper);

        boolean isACMContest = true;
        Contest contest = null;
        if(pidListDTO.getIsContestProblemList()) {
            contest = contestEntityService.getById(pidListDTO.getCid());
            if(contest == null) {
                throw new StatusNotFoundException("错误：该比赛不存在！");
            }
            isACMContest = contest.getType().intValue() == Constants.Contest.TYPE_ACM.getCode();
        }
        boolean isSealRank = false;
        if(!isACMContest && CollectionUtil.isNotEmpty(judges)) {
            isSealRank = contestValidator.isSealRank(userRolesVo.getUid(), contest, false,
                    SecurityUtils.getSubject().hasRole("root"));
        }
        for(Judge judge: judges) {
            // 如果是比赛的题目列表状态
            HashMap<String,Object> temp = new HashMap<>();
            if(pidListDTO.getIsContestProblemList()) {
                if(!isACMContest) {
                    if(!result.containsKey(judge.getPid())) {
                        // IO比赛的，如果还未写入，则使用最新一次提交的结果
                        // 判断该提交是否为封榜之后的提交,OI赛制封榜后的提交看不到提交结果，
                        // 只有比赛结束可以看到,比赛管理员与超级管理员的提交除外
                        if(isSealRank) {
                            temp.put("status", Constants.Judge.STATUS_SUBMITTED_UNKNOWN_RESULT.getStatus());
                            temp.put("score", null);
                        } else {
                            temp.put("status", judge.getStatus());
                            temp.put("score", judge.getScore());
                        }
                        result.put(judge.getPid(), temp);
                    }
                } else {
                    if(judge.getStatus().intValue() == Constants.Judge.STATUS_ACCEPTED.getStatus()) {
                        // 如果该题目已通过，且同时是为不封榜前提交的，则强制写为通过（0）
                        temp.put("status", Constants.Judge.STATUS_ACCEPTED.getStatus());
                        temp.put("score", null);
                        result.put(judge.getPid(), temp);
                    } else if(!result.containsKey(judge.getPid())) {
                        // 还未写入，则使用最新一次提交的结果
                        temp.put("status", judge.getStatus());
                        temp.put("score", null);
                        result.put(judge.getPid(), temp);
                    }
                }
            } else {  // 不是比赛题目
                if(judge.getStatus().intValue() == Constants.Judge.STATUS_ACCEPTED.getStatus()) {
                    // 如果该题目已通过，则强制写为通过（0）
                    temp.put("status", Constants.Judge.STATUS_ACCEPTED.getStatus());
                    result.put(judge.getPid(), temp);
                } else if (!result.containsKey(judge.getPid())) {
                    // 还未写入，则使用最新一次提交的结果
                    temp.put("status", judge.getStatus());
                    result.put(judge.getPid(), temp);
                }
            }
        }

        // 再次检查，应该可能从未提交过该题，则状态写为-10
        for(Long pid: pidListDTO.getPidList()) {
            // 如果是比赛的题目列表状态
            if(pidListDTO.getIsContestProblemList()) {
                if(!result.containsKey(pid)) {
                    HashMap<String,Object> temp = new HashMap<>();
                    temp.put("score", null);
                    temp.put("status", Constants.Judge.STATUS_NOT_SUBMITTED.getStatus());
                    result.put(pid, temp);
                }
            } else {
                if(!result.containsKey(pid)) {
                    HashMap<String,Object> temp = new HashMap<>();
                    temp.put("status", Constants.Judge.STATUS_NOT_SUBMITTED.getStatus());
                    result.put(pid, temp);
                }
            }
        }

        return result;
    }

    /**
     * 随机选取一道题目
     * @return
     * @throws StatusFailException
     */
    public RandomProblemVO getRandomProblem() throws StatusFailException {
        QueryWrapper<Problem> queryWrapper = new QueryWrapper<>();
        // 必须是公开题目
        queryWrapper.select("problem_id").eq("auth", 1)
                .eq("is_group", false);
        List<Problem> list = problemEntityService.list(queryWrapper);
        if(list.size() == 0) {
            throw new StatusFailException("获取随机题目失败，题库暂无公开题目！");
        }
        Random random = new Random();
        int index = random.nextInt(list.size());
        RandomProblemVO randomProblemVO = new RandomProblemVO();
        randomProblemVO.setProblemId(list.get(index).getProblemId());
        return randomProblemVO;
    }

}
