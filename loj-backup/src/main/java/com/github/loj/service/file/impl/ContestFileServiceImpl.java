package com.github.loj.service.file.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.manager.file.ContestFileManager;
import com.github.loj.service.file.ContestFileService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Service
public class ContestFileServiceImpl implements ContestFileService {

    @Resource
    private ContestFileManager contestFileManager;

    @Override
    public void downloadContestRank(Long cid, Boolean forceRefresh, Boolean removeStar, HttpServletResponse response) throws StatusForbiddenException, StatusFailException, IOException {
        contestFileManager.downloadContestRank(cid,forceRefresh,removeStar,response);
    }

    @Override
    public void downloadContestACSubmission(Long cid, Boolean excludeAdmin, String splitType, HttpServletResponse response) throws StatusForbiddenException, StatusFailException {
        contestFileManager.downloadContestACSubmission(cid, excludeAdmin, splitType, response);
    }
}
