package com.github.loj.controller.file;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.service.file.ImageService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Controller
@RequestMapping("/api/file")
public class ImageController {

    @Autowired
    private ImageService imageService;

    @PostMapping("/upload-avatar")
    @RequiresAuthentication
    @ResponseBody
    public CommonResult<Map<Object, Object>> uploadAvatar(@RequestParam("image")MultipartFile image) {
        return imageService.uploadAvatar(image);
    }

    @PostMapping("/upload-group-avatar")
    @RequiresAuthentication
    @ResponseBody
    public CommonResult<Group> uploadGroupAvatar (@RequestParam(value = "image", required = true) MultipartFile image,
                                                  @RequestParam(value = "gid", required = true) Long gid) {
        return imageService.uploadGroupAvatar(image, gid);
    }

    @PostMapping("/upload-carouse-img")
    @RequiresAuthentication
    @ResponseBody
    @RequiresRoles("root")
    public CommonResult<Map<Object,Object>> uploadCarouselImg(@RequestParam("file") MultipartFile image) {
        return imageService.uploadCarouselImg(image);
    }
}
