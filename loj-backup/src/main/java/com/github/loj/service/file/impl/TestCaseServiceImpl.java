package com.github.loj.service.file.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.file.TestCaseManager;
import com.github.loj.service.file.TestCaseService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Service
public class TestCaseServiceImpl implements TestCaseService {
    @Resource
    private TestCaseManager testCaseManager;

    @Override
    public CommonResult<Map<Object, Object>> uploadTestcaseZip(MultipartFile file, Long gid, String mode) {
        try {
            return CommonResult.successResponse(testCaseManager.uploadTestcaseZip(file, gid, mode));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusSystemErrorException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.SYSTEM_ERROR);
        }
    }

    @Override
    public void downloadTestcase(Long pid, HttpServletResponse response) throws StatusForbiddenException, StatusFailException {
        testCaseManager.downloadTestcase(pid, response);
    }
}
