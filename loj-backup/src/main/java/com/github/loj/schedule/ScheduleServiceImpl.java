package com.github.loj.schedule;

import cn.hutool.core.io.FileUtil;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.pojo.entity.common.File;
import com.github.loj.utils.Constants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/9 22:09
 */
@Service
@Slf4j(topic = "loj")
public class ScheduleServiceImpl implements ScheduleService{

    @Autowired
    private FileEntityService fileEntityService;


    /**
     * 每天3点定时查询数据库字段并删除未引用的头像
     */
    @Scheduled(cron = "0 0 3 * * *")
    @Override
    public void deleteAvatar() {
        List<File> files = fileEntityService.queryDeleteAvatarList();
        // 如果查不到，直接结束
        if(files.isEmpty()) {
            log.info("未引用的头像，查找不到退出!");
            return;
        }

        List<Long> idLists = new LinkedList<>();
        for(File file: files) {
            if(file.getDelete()) {
                boolean delSuccess = FileUtil.del(file.getFilePath());
                if(delSuccess) {
                    idLists.add(file.getId());
                }
            }
        }
        boolean isSuccess = fileEntityService.removeByIds(idLists);
        if(!isSuccess) {
            log.error("数据库file表删除头像数据失败----------------->sql语句执行失败");
        }
    }

    /**
     * 每天3点定时删除指定文件夹的上传测试数据
     */
    @Scheduled(cron = "0 0 3 * * *")
    @Override
    public void deleteTestCase() {
        boolean result = FileUtil.del(Constants.File.TESTCASE_TMP_FOLDER.getPath());
        if(!result) {
            log.error("每日定时任务异常------------------------>{}", "清除本地的题目测试数据失败!");
        }
    }
}
