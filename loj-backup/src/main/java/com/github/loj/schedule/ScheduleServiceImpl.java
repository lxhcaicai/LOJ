package com.github.loj.schedule;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.pojo.entity.common.File;
import com.github.loj.utils.Constants;
import com.github.loj.utils.JsoupUtils;
import com.github.loj.utils.RedisUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.list.AbstractLinkedList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.*;

/**
 * @author lxhcaicai
 * @date 2023/5/9 22:09
 */
@Service
@Slf4j(topic = "loj")
public class ScheduleServiceImpl implements ScheduleService{

    @Autowired
    private FileEntityService fileEntityService;

    @Autowired
    private RedisUtils redisUtils;


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

    /**
     * 每天4点定时删除本地的比赛打印数据
     */
    @Scheduled(cron = "0 0 4 * * *")
    @Override
    public void deleteContestPrintText() {
        boolean result = FileUtil.del(Constants.File.CONTEST_TEXT_PRINT_FOLDER.getPath());
        if (!result) {
            log.error("每日定时任务异常------------------------>{}", "清除本地的比赛打印数据失败!");
        }
    }

    /**
     * 每两小时获取其他OJ的比赛列表，并保存在redis里
     * 保存格式：
     * oj: "Codeforces",
     * title: "Codeforces Round #680 (Div. 1, based on VK Cup 2020-2021 - Final)",
     * beginTime: "2020-11-08T05:00:00Z",
     * endTime: "2020-11-08T08:00:00Z",
     */
    @Scheduled(cron = "0 0 0/2 * * *")
    @Override
    public void getOjContestsList() {
        // 待格式化的API，需要填充年月查询
        String nowcoderContestAPI = "https://ac.nowcoder.com/acm/calendar/contest?token=&month=%d-%d";
        // 将获取的比赛列表添加进这里
        List<Map<String,Object>> contestsList = new ArrayList<>();
        DateTime dateTime = DateUtil.date();
        // offsetMonth 增加的月份，只枚举最近3个月的比赛
        for(int offsetMonth = 0; offsetMonth <= 2; offsetMonth ++) {
            // 月份增加i个月
            DateTime newDate = DateUtil.offsetMonth(dateTime, offsetMonth);
            // 格式化API 月份从0-11，所以要加一
            String contestAPI = String.format(nowcoderContestAPI, newDate.year(), newDate.month() + 1);
            try {
                JSONObject resultObject = JsoupUtils.getJsonFromConnection(JsoupUtils.getConnectionFromUrl(contestAPI,null,null));
                // 比赛列表存放在data字段中
                JSONArray contestsArray = resultObject.getJSONArray("data");
                for(int i = contestsArray.size() - 1; i >= 0; i--) {
                    JSONObject contest = contestsArray.getJSONObject(i);
                    // 如果比赛已经结束了，则直接结束
                    if(contest.getLong("endTime", 0L) < dateTime.getTime()) {
                        break;
                    }

                    contestsList.add(MapUtil.builder(new HashMap<String,Object>())
                            .put("oj",contest.getStr("ojName"))
                            .put("url", contest.getStr("link"))
                            .put("title",contest.getStr("contestName"))
                            .put("beginTime",new Date(contest.getLong("startTime")))
                            .put("endTime", new Date(contest.getLong("endTime"))).map());
                }
            } catch (IOException e) {
                log.error("爬虫爬取Nowcoder比赛异常----------------------->{}", e.getMessage());
            }
        }

        contestsList.sort((o1,o2) -> {
            long time1 = ((Date) o1.get("beginTime")).getTime();
            long time2 = ((Date) o2.get("beginTime")).getTime();

            return Long.compare(time1, time2);
        });

        // 获取对应的redis key
        String redisKey = Constants.Schedule.RECENT_OTHER_CONTEST.getCode();
        // 缓存一天时间
        redisUtils.set(redisKey, contestsList, 60 * 60 * 24);
        // 增加log提示
        log.info("获取牛客API的比赛列表成功！共获取数据" + contestsList.size() + "条");
    }
}
