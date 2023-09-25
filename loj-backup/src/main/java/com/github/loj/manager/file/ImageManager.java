package com.github.loj.manager.file;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.common.exception.StatusForbiddenException;
import com.github.loj.common.exception.StatusSystemErrorException;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.dao.group.GroupEntityService;
import com.github.loj.dao.user.UserInfoEntityService;
import com.github.loj.dao.user.UserRoleEntityService;
import com.github.loj.pojo.entity.common.File;
import com.github.loj.pojo.entity.group.Group;
import com.github.loj.pojo.entity.user.Role;
import com.github.loj.pojo.entity.user.UserInfo;
import com.github.loj.pojo.vo.UserRolesVO;
import com.github.loj.shiro.AccountProfile;
import com.github.loj.utils.Constants;
import com.github.loj.validator.GroupValidator;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Component
@Slf4j(topic = "loj")
public class ImageManager {

    @Autowired
    private FileEntityService fileEntityService;

    @Autowired
    private UserInfoEntityService userInfoEntityService;

    @Autowired
    private UserRoleEntityService userRoleEntityService;

    @Autowired
    private GroupValidator groupValidator;

    @Autowired
    private GroupEntityService groupEntityService;


    @Transactional(rollbackFor = Exception.class)
    public Map<Object, Object> uploadAvatar(MultipartFile image) throws StatusFailException, StatusSystemErrorException {
        if (image == null) {
            throw new StatusFailException("上传的头像图片文件不能为空！");
        }
        if (image.getSize() > 1024 * 1024 * 2) {
            throw new StatusFailException("上传的头像图片文件大小不能大于2M！");
        }
        // 获取文件后缀
        String suffix = image.getOriginalFilename().substring(image.getOriginalFilename().lastIndexOf(".") + 1);
        if(!"jpg,jpeg,gif,png,web".toUpperCase().contains(suffix.toUpperCase())) {
            throw new StatusFailException("请选择jpg,jpeg,gif,png,webp格式的头像图片！");
        }
        //若不存在该目录，则创建目录
        FileUtil.mkdir(Constants.File.USER_AVATAR_FOLDER.getPath());
        // 通过UUID生成唯一的文件名
        String filename = IdUtil.simpleUUID() + "." + suffix;
        try {
            //将文件保存指定目录
            image.transferTo(FileUtil.file(Constants.File.USER_AVATAR_FOLDER.getPath() + "/" + filename));
        } catch (IOException e) {
            log.error("头像文件上传异常-------------->", e);
            throw new StatusSystemErrorException("服务器异常：头像上传失败！");
        }

        // 获取当前登录用户
        AccountProfile accountProfile = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        // 将当前用户所属的file表中avatar类型的实体的delete设置为1；
        fileEntityService.updateFileToDeleteByUidAndType(accountProfile.getUid(), "avatar");

        //更新user_info里面的avatar
        UpdateWrapper<UserInfo> userInfoUpdateWrapper = new UpdateWrapper<>();
        userInfoUpdateWrapper.set("avator", Constants.File.IMG_API.getPath() + filename)
                .eq("uuid", accountProfile.getUid());
        userInfoEntityService.update(userInfoUpdateWrapper);

        // 插入file表记录
        File imgFile = new File();
        imgFile.setName(filename).setFolderPath(Constants.File.USER_AVATAR_FOLDER.getPath())
                .setFilePath(Constants.File.USER_AVATAR_FOLDER.getPath() + "/" + filename)
                .setSuffix(suffix)
                .setType("avator")
                .setUid(accountProfile.getUid());
        fileEntityService.saveOrUpdate(imgFile);

        // 更新session
        accountProfile.setAvatar(Constants.File.IMG_API.getPath() + filename);

        UserRolesVO userRolesVO = userRoleEntityService.getUserRoles(accountProfile.getUid(), null);

        return MapUtil.builder()
                .put("uid",userRolesVO.getUid())
                .put("username",userRolesVO.getUsername())
                .put("nickname",userRolesVO.getNickname())
                .put("avatar", Constants.File.IMG_API.getPath() + filename)
                .put("email", userRolesVO.getEmail())
                .put("number", userRolesVO.getNumber())
                .put("school", userRolesVO.getSchool())
                .put("course",userRolesVO.getCourse())
                .put("signature", userRolesVO.getSignature())
                .put("realname", userRolesVO.getRealname())
                .put("github",userRolesVO.getGithub())
                .put("blog",userRolesVO.getBlog())
                .put("cfUsername", userRolesVO.getCfUsername())
                .put("roleList", userRolesVO.getRoles().stream().map(Role::getRole))
                .map();
    }

    @Transactional(rollbackFor = Exception.class)
    public Group uploadGroupAvatar(MultipartFile image, Long gid) throws StatusForbiddenException, StatusFailException, StatusSystemErrorException {
        AccountProfile userRolesVo = (AccountProfile) SecurityUtils.getSubject().getPrincipal();

        boolean isRoot = SecurityUtils.getSubject().hasRole("root");
        if (!isRoot && !groupValidator.isGroupRoot(userRolesVo.getUid(), gid)) {
            throw new StatusForbiddenException("对不起，您无权限操作！");
        }

        if (image == null) {
            throw new StatusFailException("上传的头像图片文件不能为空！");
        }
        if (image.getSize() > 1024 * 1024 * 2) {
            throw new StatusFailException("上传的头像图片文件大小不能大于2M！");
        }
        // 获取文件后缀
        String suffix = image.getOriginalFilename().substring(image.getOriginalFilename().lastIndexOf(".") + 1);
        if(!"jpg,jpeg,gif,png,web".toUpperCase().contains(suffix.toUpperCase())) {
            throw new StatusFailException("请选择jpg,jpeg,gif,png,webp格式的头像图片！");
        }
        //若不存在该目录，则创建目录
        FileUtil.mkdir(Constants.File.GROUP_AVATAR_FOLDER.getPath());

        String filename = IdUtil.simpleUUID() + "." + suffix;
        try {
            image.transferTo(FileUtil.file(Constants.File.GROUP_AVATAR_FOLDER.getPath() + "/" + filename));
        } catch (Exception e) {
            log.error("头像文件上传异常-------------->", e);
            throw new StatusSystemErrorException("服务器异常：头像上传失败！");
        }

        fileEntityService.updateFileToDeleteByGidAndType(gid,"avatar");
        UpdateWrapper<Group> groupUpdateWrapper = new UpdateWrapper<>();
        groupUpdateWrapper.set("avatar", Constants.File.IMG_API.getPath() + filename)
                .eq("id", gid);
        groupEntityService.update(groupUpdateWrapper);

        File imgFile = new File();
        imgFile.setName(filename).setFolderPath(Constants.File.GROUP_AVATAR_FOLDER.getPath())
                .setFilePath(Constants.File.GROUP_AVATAR_FOLDER.getPath() + "/" + filename)
                .setSuffix(suffix)
                .setType("avatar")
                .setGid(gid);

        fileEntityService.saveOrUpdate(imgFile);

        Group group = groupEntityService.getById(gid);

        return group;
    }
}
