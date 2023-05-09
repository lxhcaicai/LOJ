package com.github.loj.service.file.impl;

import com.github.loj.manager.file.UserFileManager;
import com.github.loj.service.file.UserFileService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author lxhcaicai
 * @date 2023/5/9 21:16
 */
@Service
public class UserFileServiceImpl implements UserFileService {

    @Resource
    private UserFileManager userFileManager;

    @Override
    public void generateUserExcel(String key, HttpServletResponse response) throws IOException {
        userFileManager.generateUserExcel(key, response);
    }
}
