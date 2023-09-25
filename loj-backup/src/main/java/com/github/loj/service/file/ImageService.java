package com.github.loj.service.file;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.group.Group;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface ImageService {
    public CommonResult<Map<Object, Object>> uploadAvatar(MultipartFile image);

    public CommonResult<Group> uploadGroupAvatar(MultipartFile image, Long gid);
}
