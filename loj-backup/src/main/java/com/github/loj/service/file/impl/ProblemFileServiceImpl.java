package com.github.loj.service.file.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.file.ProblemFileManager;
import com.github.loj.service.file.ProblemFileService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Service
public class ProblemFileServiceImpl implements ProblemFileService {

    @Resource
    private ProblemFileManager problemFileManager;

    @Override
    public void exportProblem(List<Long> pidList, HttpServletResponse response) {
        problemFileManager.exportProblem(pidList, response);
    }

    @Override
    public CommonResult<Void> importProblem(MultipartFile file) {
        try {
            problemFileManager.importProblem(file);
            return CommonResult.successResponse();
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusSystemErrorException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.SYSTEM_ERROR);
        }
    }
}
