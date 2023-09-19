package com.github.loj.crawler.problem;

import lombok.extern.slf4j.Slf4j;

@Slf4j(topic = "loj")
public class ProblemContext {

    ProblemStrategy problemStrategy;

    public ProblemContext(ProblemStrategy problemStrategy) {
        this.problemStrategy = problemStrategy;
    }

    //上下文接口
    public ProblemStrategy.RemoteProblemInfo getProblemInfo(String problemId, String author) throws Exception {
        try {
            return problemStrategy.getProblemInfo(problemId, author);
        }  catch (IllegalArgumentException e) {
            throw e;
        }  catch (Exception e) {
            log.error("获取题目详情失败---------------->{}", e);
            throw e;
        }
    }

    public ProblemStrategy.RemoteProblemInfo getProblemInfoByLogin(String problemId, String author, String username, String password) {
        try {
            return problemStrategy.getProblemInfoByLogin(problemId, author, username, password);
        } catch (Exception e) {
            log.error("获取题目详情失败---------------->{}", e);
        }
        return null;
    }
}
