package com.github.loj.crawler.problem;

import com.github.loj.pojo.entity.problem.Problem;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.utils.Constants;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

public abstract class ProblemStrategy {
    public abstract RemoteProblemInfo getProblemInfo(String problemId, String author) throws Exception;

    public RemoteProblemInfo getProblemInfoByLogin(String problemId, String author, String username, String password) throws Exception {
        return null;
    }

    @Data
    @Accessors(chain = true)
    public static class  RemoteProblemInfo {
        private Problem problem;
        private List<Tag> tagList;
        private List<String> langIdList;
        private Constants.RemoteOJ remoteOJ;
    }
}
