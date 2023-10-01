package com.github.loj.service.file;

import com.github.loj.common.result.CommonResult;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface TestCaseService {
    public CommonResult<Map<Object, Object>> uploadTestcaseZip(MultipartFile file, Long gid, String mode);
}
