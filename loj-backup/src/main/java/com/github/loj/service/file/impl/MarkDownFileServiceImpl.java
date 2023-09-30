package com.github.loj.service.file.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.file.MarkDownFileManager;
import com.github.loj.service.file.MarkDownFileService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.Map;

@Service
public class MarkDownFileServiceImpl implements MarkDownFileService {
    @Resource
    private MarkDownFileManager markDownFileManager;

    @Override
    public CommonResult<Map<Object, Object>> uploadMDImg(MultipartFile image, Long gid) {
        try {
            return CommonResult.successResponse(markDownFileManager.uploadMDImg(image,gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusSystemErrorException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.SYSTEM_ERROR);
        }
    }

    @Override
    public CommonResult<Void> deleteMDImg(Long fileId) {
        try {
            markDownFileManager.deleteMDImg(fileId);
            return CommonResult.successResponse();
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        }
    }

    @Override
    public CommonResult<Map<Object, Object>> uploadMd(MultipartFile file, Long gid) {
        try {
            return CommonResult.successResponse(markDownFileManager.uploadMd(file, gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusSystemErrorException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.SYSTEM_ERROR);
        }
    }
}
