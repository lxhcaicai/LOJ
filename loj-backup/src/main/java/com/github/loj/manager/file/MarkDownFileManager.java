package com.github.loj.manager.file;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.IdUtil;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.pojo.entity.common.File;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.GroupValidator;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Component
@Slf4j(topic = "loj")
public class MarkDownFileManager {

    @Autowired
    private FileEntityService fileEntityService;

    @Autowired
    private GroupValidator groupValidator;

    public Map<Object, Object> uploadMDImg(MultipartFile image, Long gid) throws StatusForbiddenException, StatusFailException, StatusSystemErrorException {
        AccountProfile userRoleVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");
        boolean isAdmin = SecurityUtils.getSubject().hasRole("admin");

        if (!isRoot
                && !isProblemAdmin
                && !isAdmin
                && !(gid != null && groupValidator.isGroupRoot(userRoleVo.getUid(), gid))) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if (image == null) {
            throw new StatusFailException("上传的图片不能为空！");
        }
        if (image.getSize() > 1024 * 1024 * 4) {
            throw new StatusFailException("上传的图片文件大小不能大于4M！");
        }
        // 获取文件后最
        String suffix = image.getOriginalFilename().substring(image.getOriginalFilename().lastIndexOf(".") + 1);
        if (!"jpg,jepg,gif,png,webp".toUpperCase().contains(suffix.toUpperCase())) {
            throw new StatusFailException("请选择jpg,jpeg,gif,png,webp格式的图片！");
        }

        //若不存在该目录，则创建目录
        FileUtil.mkdir(Constants.File.MARKDOWN_FILE_FOLDER.getPath());

        //通过UUID生成唯一文件名
        String filename = IdUtil.simpleUUID() + "." + suffix;

        try {
            //将文件保存指定目录
            image.transferTo(FileUtil.file(Constants.File.MARKDOWN_FILE_FOLDER.getPath() + "/" + filename));
        } catch (Exception e) {
            log.error("图片文件上传异常-------------->", e);
            throw new StatusSystemErrorException("服务器异常：图片文件上传失败！");
        }

        File file = new File();
        file.setFilePath(Constants.File.MARKDOWN_FILE_FOLDER.getPath())
                .setName(filename)
                .setFilePath(Constants.File.MARKDOWN_FILE_FOLDER.getPath() + "/" + filename)
                .setSuffix(suffix)
                .setType("md")
                .setUid(userRoleVo.getUid());
        fileEntityService.save(file);

        return MapUtil.builder()
                .put("link", Constants.File.IMG_API.getPath() + filename)
                .put("fileId", file.getId()).map();
    }

    public void deleteMDImg(Long fileId) throws StatusFailException, StatusForbiddenException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        File file = fileEntityService.getById(fileId);

        if (file == null) {
            throw new StatusFailException("错误：文件不存在！");
        }

        if (!file.getType().equals("md")) {
            throw new StatusForbiddenException("错误：不支持删除！");
        }

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        boolean isProblemAdmin = SecurityUtils.getSubject().hasRole("problem_admin");

        Long gid = file.getGid();

        if (!file.getUid().equals(userRolesVo.getUid())
                && !isRoot
                && !isProblemAdmin
                && !(gid != null && groupValidator.isGroupAdmin(userRolesVo.getUid(), gid))) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        boolean isOk = FileUtil.del(file.getFilePath());
        if (isOk) {
            fileEntityService.removeById(fileId);
        } else {
            throw new StatusFailException("删除失败");
        }
    }
}
