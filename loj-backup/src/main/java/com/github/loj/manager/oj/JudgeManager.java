package com.github.loj.manager.oj;

import cn.hutool.core.util.IdUtil;
import cn.hutool.json.JSONUtil;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.config.NacosSwitchConfig;
import com.github.loj.config.SwitchConfig;
import com.github.loj.dao.problem.ProblemEntityService;
import com.github.loj.judge.self.JudgeDispatcher;
import com.github.loj.pojo.dto.SubmitJudgeDTO;
import com.github.loj.pojo.dto.TestJudgeDTO;
import com.github.loj.pojo.dto.TestJudgeReq;
import com.github.loj.pojo.dto.TestJudgeRes;
import com.github.loj.pojo.entity.judge.Judge;
import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.vo.TestJudgeVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.utils.IpUtils;
import com.github.loj.utils.RedisUtils;
import com.github.loj.validator.JudgeValidator;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.rmi.AccessException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/5/6 22:09
 */
@Component
public class JudgeManager {


    @Autowired
    private JudgeValidator judgeValidator;

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private ProblemEntityService problemEntityService;

    @Autowired
    private JudgeDispatcher judgeDispatcher;

    @Autowired
    private NacosSwitchConfig nacosSwitchConfig;

    @Autowired
    private BeforeDispatchInitManager beforeDispatchInitManager;

    public String submitProblemTestJudge(TestJudgeDTO testJudgeDTO) throws AccessException,
            StatusFailException, StatusForbiddenException, StatusSystemErrorException {
        judgeValidator.validateTestJudgeInfo(testJudgeDTO);
        // 需要获取一下该token对应用户的数据
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        String lockKey = Constants.Account.TEST_JUDGE_LOCK.getCode() + userRolesVo.getUid();
        long count = redisUtils.incr(lockKey,1);
        if(count > 1) {
            throw new StatusForbiddenException("对不起，您使用在线调试过于频繁，请稍后再尝试！");
        }
        redisUtils.expire(lockKey, 3);

        Problem problem = problemEntityService.getById(testJudgeDTO.getPid());

        if(problem == null) {
            throw new StatusFailException("当前题目不存在！不支持在线调试！");
        }

        String uniqueKey = "TEST_JUDGE_" + IdUtil.simpleUUID();

        TestJudgeReq testJudgeReq = new TestJudgeReq();
        testJudgeReq.setMemoryLimit(problem.getMemoryLimit())
                .setTimeLimit(problem.getTimeLimit())
                .setStackLimit(problem.getStackLimit())
                .setCode(testJudgeDTO.getCode())
                .setLanguage(testJudgeDTO.getLanguage())
                .setUniqueKey(uniqueKey)
                .setExpectedOutput(testJudgeDTO.getExpectedOutput())
                .setTestCaseInput(testJudgeDTO.getUserInput())
                .setProblemJudgeMode(problem.getJudgeMode())
                .setIsRemoveEndBlank(problem.getIsRemoveEndBlank() || problem.getIsRemote());

        String userExtraFile = problem.getUserExtraFile();
        if(!StringUtils.isEmpty(userExtraFile)) {
            testJudgeReq.setExtraFile((HashMap<String, String>) JSONUtil.toBean(userExtraFile, Map.class));
        }
        judgeDispatcher.sendTestJudgeTask(testJudgeReq);
        redisUtils.set(uniqueKey, TestJudgeRes.builder()
                .status(Constants.Judge.STATUS_PENDING.getStatus())
                .build(),10*60);
        return uniqueKey;
    }

    public TestJudgeVO getTestJudgeResult(String testJudgeKey) throws StatusFailException {
        TestJudgeRes testJudgeRes = (TestJudgeRes) redisUtils.get(testJudgeKey);
        if(testJudgeRes == null) {
            throw new StatusFailException("查询错误！当前在线调试任务不存在！");
        }
        TestJudgeVO testJudgeVO = new TestJudgeVO();
        testJudgeVO.setStatus(testJudgeRes.getStatus());
        if(Constants.Judge.STATUS_PENDING.getStatus().equals(testJudgeRes.getStatus())) {
            return testJudgeVO;
        }
        testJudgeVO.setUserInput(testJudgeRes.getInput());
        testJudgeVO.setUserOutput(testJudgeRes.getStdout());
        testJudgeVO.setExpectedOutput(testJudgeRes.getExpectedOutput());
        testJudgeVO.setMemory(testJudgeRes.getMemory());
        testJudgeVO.setTime(testJudgeRes.getTime());
        testJudgeVO.setStderr(testJudgeRes.getStderr());
        testJudgeVO.setProblemJudgeMode(testJudgeRes.getProblemJudgeMode());
        redisUtils.del(testJudgeKey);
        return testJudgeVO;
    }

    public Judge submitProblemJudge(SubmitJudgeDTO judgeDTO) throws AccessException, StatusFailException, StatusForbiddenException {
        judgeValidator.validateSubmissionInfo(judgeDTO);

        // 需要获取一下该token对应用户的数据
        AccountProfile userRoleVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isContestSubmission = judgeDTO.getCid() != null && judgeDTO.getCid() != 0;
        boolean isTrainingSubmission = judgeDTO.getTid() != null && judgeDTO.getTid() != 0;

        SwitchConfig switchConfig = nacosSwitchConfig.getSwitchConfig();
        if(!isContestSubmission && switchConfig.getDefaultSubmitInterval() > 0) { // 非比赛提交有限制限制
            String lockKey = Constants.Account.SUBMIT_CONTEST_LOCK.getCode() + userRoleVo.getUid();
            long count = redisUtils.incr(lockKey, 1);
            if(count > 1) {
                throw new StatusForbiddenException("对不起，您的提交频率过快，请稍后再尝试！");
            }
            redisUtils.expire(lockKey, switchConfig.getDefaultSubmitInterval());
        }

        HttpServletRequest request = ((ServletRequestAttributes) (RequestContextHolder.currentRequestAttributes())).getRequest();

        // 将提交先写入数据库，准备调用判题服务器
        Judge judge = new Judge();
        judge.setShare(false)
                .setCode(judgeDTO.getCode())
                .setCid(judgeDTO.getCid())
                .setGid(judgeDTO.getGid())
                .setLanguage(judgeDTO.getLanguage())
                .setLength(judgeDTO.getCode().length())
                .setUid(userRoleVo.getUid())
                .setUsername(userRoleVo.getUsername())
                .setStatus(Constants.Judge.STATUS_PENDING.getStatus()) // 开始进入判题队列
                .setSubmitTime(new Date())
                .setVersion(0)
                .setIp(IpUtils.getUserIpAddr(request));

        // 如果比赛id不等于0，则说明为比赛提交
        if(isContestSubmission) {
            // TODO
        } else if(isTrainingSubmission) {
            // TODO
        } else {
            beforeDispatchInitManager.initCommonSubmission(judgeDTO.getPid(), judgeDTO.getGid(), judge);
        }

        // 将提交加入任务队列
        if(judgeDTO.getIsRemote()) { // 如果是远程oj判题
            // TODO
        } else {
            judgeDispatcher.sendTask(judge.getSubmitId(),
                    judge.getPid(),
                    isContestSubmission);
        }

        return judge;
    }
}
