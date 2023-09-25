package com.github.loj.service.file;

import com.github.loj.common.result.CommonResult;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface ImageService {
    public CommonResult<Map<Object, Object>> uploadAvatar(MultipartFile image);
}
