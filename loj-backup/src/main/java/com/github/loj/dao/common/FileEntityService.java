package com.github.loj.dao.common;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.loj.pojo.entity.common.File;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/9 22:18
 */
public interface FileEntityService extends IService<File> {
    List<File> queryDeleteAvatarList();
}
