package com.github.loj.manager.oj;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.annotation.LOJAccessEnum;
import com.github.loj.common.exception.StatusAccessDeniedException;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusNotFoundException;
import com.github.loj.dao.contest.ContestEntityService;
import com.github.loj.dao.judge.JudgeEntityService;
import com.github.loj.dao.problem.*;
import com.github.loj.pojo.dto.PidListDTO;
import com.github.loj.pojo.entity.contest.Contest;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.*;
import com.github.loj.pojo.vo.*;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.AccessValidator;
import com.github.loj.validator.ContestValidator;
import com.github.loj.validator.GroupValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.rmi.AccessException;
import java.util.*;
import java.util.stream.Collectors;

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

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private ProblemTagEntityService problemTagEntityService;

    @Autowired
    private TagEntityService tagEntityService;

    @Autowired
    private ProblemLanguageEntityService problemLanguageEntityService;

    @Autowired
    private LanguageEntityService languageEntityService;

    @Autowired
    private CodeTemplateEntityService codeTemplateEntityService;

    @Autowired
    private AccessValidator accessValidator;

    @Autowired
    private TrainingManager trainingManager;

    @Autowired
    private ContestManager contestManager;

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

    /**
     * 获取指定题目的详情信息，标签，所支持语言，做题情况（只能查询公开题目 也就是auth为1）
     * @param problemId
     * @param gid
     * @return
     * @throws StatusNotFoundException
     * @throws StatusForbiddenException
     */
    public ProblemInfoVO getProblemInfo(String problemId, Long gid) throws StatusNotFoundException, StatusForbiddenException {
        QueryWrapper<Problem> wrapper = new QueryWrapper<Problem>().eq("problem_id",problemId);
        //查询题目详情，题目标签，题目语言，题目做题情况
        Problem problem = problemEntityService.getOne(wrapper, false);
        if(problem == null) {
            throw new StatusNotFoundException("该题号对应的题目不存在");
        }
        if(problem.getAuth() != 1) {
            throw new StatusForbiddenException("该题号对应题目并非公开题目，不支持访问！");
        }

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        if(problem.getIsGroup() && !isRoot) {
            if(gid == null) {
                throw new StatusForbiddenException("题目为团队所属，此处不支持访问，请前往团队查看！");
            }
            if(!groupValidator.isGroupMember(userRolesVo.getUid(), problem.getGid())) {
                throw new StatusForbiddenException("对不起，您并非该题目所属的团队内成员，无权查看题目！");
            }
        }

        QueryWrapper<ProblemTag> problemTagQueryWrapper = new QueryWrapper<>();
        problemTagQueryWrapper.eq("pid", problem.getId());

        // 获取该题号对应的标签id
        List<Long> tidList = new LinkedList<>();
        problemTagEntityService.list(problemTagQueryWrapper).forEach(problemTag -> {
            tidList.add(problemTag.getTid());
        });
        List<Tag> tags = new ArrayList<>();
        if(tidList.size() > 0) {
            tags = (List<Tag>) tagEntityService.listByIds(tidList);
        }

        // 记录 languageId对应的name
        HashMap<Long,String> tmpMap = new HashMap<>();
        // 获取题目提交的代码支持的语言
        List<String> languagesStr = new LinkedList<>();
        QueryWrapper<ProblemLanguage> problemLanguageQueryWrapper = new QueryWrapper<>();
        problemLanguageQueryWrapper.eq("pid",problem.getId()).select("lid");
        List<Long> lidList = problemLanguageEntityService.list(problemLanguageQueryWrapper)
                .stream().map(ProblemLanguage::getLid).collect(Collectors.toList());
        if(CollectionUtil.isNotEmpty(lidList)) {
            Collection<Language> languages = languageEntityService.listByIds(lidList);
            languages = languages.stream().sorted(Comparator.comparing(Language::getSeq,Comparator.reverseOrder())
                        .thenComparing(Language::getId))
                    .collect(Collectors.toList());
            languages.forEach(language -> {
                languagesStr.add(language.getName());
                tmpMap.put(language.getId(),language.getName());
            });
        }

        // 获取题目的提交记录
        ProblemCountVO problemCount = judgeEntityService.getProblemCount(problem.getId(),gid);

        // 获取题目的代码模板
        QueryWrapper<CodeTemplate> codeTemplateQueryWrapper = new QueryWrapper<>();
        codeTemplateQueryWrapper.eq("pid", problem.getId()).eq("status",true);
        List<CodeTemplate> codeTemplates = codeTemplateEntityService.list(codeTemplateQueryWrapper);
        HashMap<String, String> LangNameAndCode = new HashMap<>();
        if(CollectionUtil.isNotEmpty(codeTemplates)) {
            for(CodeTemplate codeTemplate: codeTemplates) {
                LangNameAndCode.put(tmpMap.get(codeTemplate.getLid()),codeTemplate.getCode());
            }
        }
        // 屏蔽一些题目参数
        problem.setJudgeExtraFile(null)
                .setSpjCode(null)
                .setSpjLanguage(null);

        // 将数据统一写入到一个Vo返回数据实体类中
        return new ProblemInfoVO(problem, tags, languagesStr, problemCount, LangNameAndCode);
    }

    public LastAcceptedCodeVO getUserLastAcceptedCode(Long pid, Long cid) {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        if(cid == null) {
            cid = 0L;
        }
        QueryWrapper<Judge> judgeQueryWrapper = new QueryWrapper<>();
        judgeQueryWrapper.select("submit_id", "cid", "code", "username", "submit_time", "language")
                .eq("uid", userRolesVo.getUid())
                .eq("pid", pid)
                .eq("cid", cid)
                .eq("status", 0)
                .orderByDesc("submit_id")
                .last("limit 1");
        List<Judge> judgeList = judgeEntityService.list(judgeQueryWrapper);
        LastAcceptedCodeVO lastAcceptedCodeVO = new LastAcceptedCodeVO();
        if(CollectionUtil.isNotEmpty(judgeList)) {
            Judge judge = judgeList.get(0);
            lastAcceptedCodeVO.setSubmitId(judge.getSubmitId());
            lastAcceptedCodeVO.setLanguage(judge.getLanguage());
            lastAcceptedCodeVO.setCode(buildCode(judge));
        } else {
            lastAcceptedCodeVO.setCode("");
        }
        return lastAcceptedCodeVO;
    }

    private String buildCode(Judge judge) {
        if(judge.getCid() == 0) {
            // 比赛外的提交代码 如果不是超管或题目管理员，需要检查网站是否开启隐藏代码功能
            boolean isRoot = SecurityUtils.getSubject().hasRole("root");
            boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
            if(!isRoot && !isProblemAdmin) {
                try {
                    accessValidator.validateAccess(LOJAccessEnum.HIDE_NON_CONTEST_SUBMISSION_CODE);
                } catch (AccessException e) {
                    return "Because the super administrator has enabled " +
                            "the function of not viewing the submitted code outside the contest of master station, \n" +
                            "the code of this submission details has been hidden.";
                }
            }
        }

        if(!judge.getLanguage().toLowerCase(Locale.ROOT).contains("py")) {
            return judge.getCode() + "\n\n" +
                    "/**\n" +
                    "* @runId: " + judge.getSubmitId() + "\n" +
                    "* @language: " + judge.getLanguage() + "\n" +
                    "* @author: " + judge.getUsername() + "\n" +
                    "* @submitTime: " + DateUtil.format(judge.getSubmitTime(), "yyyy-MM-dd HH:mm:ss") + "\n" +
                    "*/";
        } else {
            return judge.getCode() + "\n\n" +
                    "'''\n" +
                    "    @runId: " + judge.getSubmitId() + "\n" +
                    "    @language: " + judge.getLanguage() + "\n" +
                    "    @author: " + judge.getUsername() + "\n" +
                    "    @submitTime: " + DateUtil.format(judge.getSubmitTime(), "yyyy-MM-dd HH:mm:ss") + "\n" +
                    "'''";
        }

    }

    public List<ProblemFullScreenListVO> getFullScreenProblemList(Long tid,Long cid) throws StatusForbiddenException, StatusFailException, StatusAccessDeniedException {
        if(tid != null) {
            return trainingManager.getProblemFullScreenList(tid);
        } else if(cid != null && cid != 0) {
            return contestManager.getContestFullScreenProblemList(cid);
        } else {
            throw new StatusFailException("请求参数错误：tid或cid不能为空");
        }
    }

}
