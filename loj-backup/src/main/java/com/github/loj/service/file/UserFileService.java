package com.github.loj.service.file;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author lxhcaicai
 * @date 2023/5/9 21:15
 */
public interface UserFileService {

    public void generateUserExcel(String key, HttpServletResponse response) throws IOException;

}
