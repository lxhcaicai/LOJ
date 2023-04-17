package com.github.loj.controller;

import com.github.loj.service.SystemConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/4/17 22:55
 */
@RestController
public class SystemConfigController {

    @Autowired
    private SystemConfigService systemConfigService;

    @RequestMapping("/get-sys-config")
    public HashMap<String,Object> getSystemConfig() {
        return systemConfigService.getSystemConfig();
    }
}
