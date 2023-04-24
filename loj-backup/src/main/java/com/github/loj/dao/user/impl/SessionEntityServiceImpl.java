package com.github.loj.dao.user.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.msg.AdminSysNoticeEntityService;
import com.github.loj.dao.msg.UserSysNoticeEntityService;
import com.github.loj.dao.user.SessionEntityService;
import com.github.loj.mapper.SessionMapper;
import com.github.loj.pojo.entity.msg.AdminSysNotice;
import com.github.loj.pojo.entity.msg.UserSysNotice;
import com.github.loj.pojo.entity.user.Session;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/4/24 20:33
 */
@Service
public class SessionEntityServiceImpl extends ServiceImpl<SessionMapper, Session> implements SessionEntityService {

    @Resource
    private SessionMapper sessionMapper;

    @Resource
    private AdminSysNoticeEntityService adminSysNoticeEntityService;

    @Resource
    private UserSysNoticeEntityService userSysNoticeEntityService;


    @Override
    @Async
    public void checkRemoteLogin(String uid) {
        QueryWrapper<Session> sessionQueryWrapper = new QueryWrapper<>();
        sessionQueryWrapper.eq("uid", uid)
                .orderByDesc("gmt_create")
                .last("limit 2");

        List<Session> sessionList = sessionMapper.selectList(sessionQueryWrapper);
        if(sessionList.size() < 2) {
            return;
        }
        Session nowSession = sessionList.get(0);
        Session lastSession = sessionList.get(1);

        if(!nowSession.getIp().equals(lastSession.getIp())) {
            String remoteLoginContent = getRemoteLoginContent(lastSession.getIp(), nowSession.getIp(), nowSession.getGmtCreate());

            if(remoteLoginContent == null) {
                return;
            }
            AdminSysNotice adminSysNotice = new AdminSysNotice();
            adminSysNotice
                    .setType("Single")
                    .setTitle("账号异地登录通知(Account Remote Login Notice)")
                    .setContent(remoteLoginContent)
                    .setAdminId("1")
                    .setState(false)
                    .setRecipientId(uid);

            boolean isSaveOk = adminSysNoticeEntityService.save(adminSysNotice);

            if(isSaveOk) {
                UserSysNotice userSysNotice = new UserSysNotice();
                userSysNotice
                        .setType("Sys")
                        .setSysNoticeId(adminSysNotice.getId())
                        .setState(false);

                boolean isOk = userSysNoticeEntityService.save(userSysNotice);
                if(isOk) {
                    adminSysNotice.setState(true);
                    adminSysNoticeEntityService.saveOrUpdate(adminSysNotice);
                }
            }

        }
    }

    private String getRemoteLoginContent(String oldIp, String newIp, Date loginDate) {
        String dateStr = DateUtil.format(loginDate, "yyyy-MM-dd HH:mm:ss");
        StringBuilder sb = new StringBuilder();
        sb.append("亲爱的用户，您好！您的账号于").append(dateStr);
        String addr = null;
        try {
            String newRes = HttpUtil.get("https://whois.pconline.com.cn/ipJson.jsp?ip=" + newIp + "&json=true");
            JSONObject newResJson = JSONUtil.parseObj(newRes);
            addr = newResJson.getStr("addr");

            String newCityCode = newResJson.getStr("cityCode");

            String oldRes = HttpUtil.get("https://whois.pconline.com.cn/ipJson.jsp?ip=" + oldIp + "&json=true");
            JSONObject oldResJson = JSONUtil.parseObj(oldRes);

            String oldCityCode = oldResJson.getStr("cityCode");

            if(newCityCode == null || oldCityCode == null || newCityCode.equals(oldCityCode)) {
                return  null;
            }
        } catch (Exception ignored) {
            return  null;
        }

        if(!StringUtils.isEmpty(addr)) {
            sb.append("在【")
                    .append(addr)
                    .append("】");
        }
        sb.append("登录，登录IP为：【")
                .append(newIp)
                .append("】，若非本人操作，请立即修改密码。")
                .append("\n\n")
                .append("Hello! Dear user, Your account was logged in in");

        if(!StringUtils.isEmpty(addr)) {
            sb.append(" 【")
                    .append(addr)
                    .append("】 on ")
                    .append(dateStr)
                    .append(". If you do not operate by yourself, please change your password immediately.");
        }

        return sb.toString();
    }
}
