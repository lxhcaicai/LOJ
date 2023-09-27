package com.github.loj.service.file.impl;

import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.manager.file.ImageManager;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.service.file.ImageService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.Map;

@Service
public class ImageServiceImpl implements ImageService {

    @Resource
    private ImageManager imageManager;

    @Override
    public CommonResult<Map<Object, Object>> uploadAvatar(MultipartFile image) {
        try {
            return CommonResult.successResponse(imageManager.uploadAvatar(image));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusSystemErrorException e) {
            return CommonResult.errorResponse(e.getMessage(), ResultStatus.SYSTEM_ERROR);
        }
    }

    @Override
    public CommonResult<Group> uploadGroupAvatar(MultipartFile image, Long gid) {
        try {
            return CommonResult.successResponse(imageManager.uploadGroupAvatar(image, gid));
        } catch (StatusForbiddenException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.FORBIDDEN);
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusSystemErrorException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.SYSTEM_ERROR);
        }
    }

    @Override
    public CommonResult<Map<Object, Object>> uploadCarouselImg(MultipartFile image) {
        try {
            return CommonResult.successResponse(imageManager.uploadCarouselImg(image));
        } catch (StatusFailException e) {
            return CommonResult.errorResponse(e.getMessage());
        } catch (StatusSystemErrorException e) {
            return CommonResult.errorResponse(e.getMessage(),ResultStatus.SYSTEM_ERROR);
        }
    }

}
