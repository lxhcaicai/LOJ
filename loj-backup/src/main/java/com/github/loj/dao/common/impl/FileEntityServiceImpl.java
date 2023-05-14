package com.github.loj.dao.common.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.mapper.FileMapper;
import com.github.loj.pojo.entity.common.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/9 22:20
 */
@Service
public class FileEntityServiceImpl extends ServiceImpl<FileMapper, File> implements FileEntityService {

    @Autowired
    private FileMapper fileMapper;

    @Override
    public List<File> queryDeleteAvatarList() {
        return fileMapper.queryDeleteAvatarList();
    }

    @Override
    public List<File> queryCarouselFileList() {
        return fileMapper.queryCarouselFileList();
    }
}
