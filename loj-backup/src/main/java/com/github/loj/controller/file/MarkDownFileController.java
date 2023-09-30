package com.github.loj.controller.file;

import com.github.loj.common.result.CommonResult;
import com.github.loj.service.file.MarkDownFileService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/api/file")
public class MarkDownFileController {

    @Resource
    private MarkDownFileService markDownFileService;

    public CommonResult<Map<Object,Object>> uploadMDImg(@RequestParam("image")MultipartFile image,
                                                         @RequestParam(value = "gid", required = false)Long gid) {
        return markDownFileService.uploadMDImg(image, gid);
    }
}
