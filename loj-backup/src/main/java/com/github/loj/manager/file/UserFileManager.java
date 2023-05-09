package com.github.loj.manager.file;

import com.alibaba.excel.EasyExcel;
import com.github.loj.pojo.vo.ExcelUserVO;
import com.github.loj.utils.RedisUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * @author lxhcaicai
 * @date 2023/5/9 21:17
 */
@Component
@Slf4j(topic = "loj")
public class UserFileManager {

    @Autowired
    private RedisUtils redisUtils;

    public void generateUserExcel(String key, HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("utf-8");
        // 这里URLEncoder.encode可以防止中文乱码
        String fileName = URLEncoder.encode(key,"UTF-8");
        response.setHeader("Content-disposition", "attachment;filename=" + fileName + ".xlsx");
        response.setHeader("Content-type", "application/xlsx");
        EasyExcel.write(response.getOutputStream(), ExcelUserVO.class).sheet("用户数据").doWrite(getGenerateUsers(key));
    }

    private List<ExcelUserVO> getGenerateUsers(String key) {
        List<ExcelUserVO> result = new LinkedList<>();
        Map<Object,Object> userInfo = redisUtils.hmget(key);
        for(Object hashKey: userInfo.keySet()) {
            String username = (String) hashKey;
            String password = (String) userInfo.get(hashKey);
            result.add(new ExcelUserVO().setUsername(username).setPassword(password));
        }
        return result;
    }

}
