package com.github.loj.controller.file;

import com.github.loj.common.result.CommonResult;
import com.github.loj.service.file.MarkDownFileService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/api/file")
public class MarkDownFileController {

    @Resource
    private MarkDownFileService markDownFileService;

    @RequestMapping(value = "/upload-md-img", method = RequestMethod.POST)
    @RequiresAuthentication
    @ResponseBody
    public CommonResult<Map<Object,Object>> uploadMDImg(@RequestParam("image")MultipartFile image,
                                                         @RequestParam(value = "gid", required = false)Long gid) {
        return markDownFileService.uploadMDImg(image, gid);
    }

    @GetMapping("/delete-md-img")
    @RequiresAuthentication
    @ResponseBody
    public CommonResult<Void> deleteMDImg(@RequestParam("fileId") Long fileId) {
        return markDownFileService.deleteMDImg(fileId);
    }

    @PostMapping("/upload-md-file")
    @RequiresAuthentication
    @ResponseBody
    public CommonResult<Map<Object,Object>> uploadMd(@RequestParam("file") MultipartFile file,
                                                     @RequestParam(value = "gid", required = false) Long gid) {
        return markDownFileService.uploadMd(file, gid);
    }
}
