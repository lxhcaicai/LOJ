package com.github.loj.utils;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * @author lxhcaicai
 * @date 2023/4/24 23:48
 */
@Slf4j(topic = "loj")
public class IpUtils {
    public static String getUserIpAddr(HttpServletRequest request) {
        String ipAddress = null;
        try {
            ipAddress = request.getHeader("x-forwarded-for");
            if(ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getHeader("Proxy-Client-IP");
            }
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getHeader("WL-Proxy-Client-IP");
            }
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
               ipAddress = request.getRemoteAddr();
               if(ipAddress.equals("127.0.0.1")) {
                   try {
                       ipAddress = InetAddress.getLocalHost().getHostAddress();
                   } catch (UnknownHostException e) {
                       log.error("用户ip获取异常------->{}", e.getMessage());
                   }
               }
            }
            // 通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
            if(ipAddress != null) {
                if(ipAddress.contains(",")) {
                    return ipAddress.split(",")[0];
                } else {
                    return ipAddress;
                }
            } else {
                return "";
            }
        } catch (Exception e) {
            log.error("用户ip获取异常------->{}", e.getMessage());
            return "";
        }
    }

    public static String getServiceIp() {
        InetAddress address = null;
        try {
            address = InetAddress.getLocalHost();
            return address.getHostAddress();
        } catch (UnknownHostException e) {
            log.error("本地ip获取异常---------->{}", e.getMessage());
        }
        return null;
    }
}
