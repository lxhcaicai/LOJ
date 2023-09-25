package com.github.loj.controller.file;

import com.github.loj.common.result.CommonResult;
import com.github.loj.service.file.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Controller
@RequestMapping("/api/file")
public class ImageController {

    @Autowired
    private ImageService imageService;

    public CommonResult<Map<Object, Object>> uploadAvatar(@RequestParam("image")MultipartFile image) {
        return imageService.uploadAvatar(image);
    }
}
