package com.github.loj.service.file;

import com.github.loj.common.result.CommonResult;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface MarkDownFileService {
    public CommonResult<Map<Object, Object>> uploadMDImg(MultipartFile image, Long gid);
}
