package com.github.loj.service.file;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface ContestFileService {
    public void downloadContestRank(Long cid, Boolean forceRefresh, Boolean removeStar, HttpServletResponse response) throws StatusForbiddenException, StatusFailException, IOException;

    public void downloadContestACSubmission(Long cid, Boolean excludeAdmin, String splitType, HttpServletResponse response) throws StatusForbiddenException, StatusFailException;

    public void downloadContestPrintText(Long id, HttpServletResponse response) throws StatusForbiddenException;
}
