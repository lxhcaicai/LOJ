package com.github.loj.controller.admin;

import cn.hutool.json.JSONObject;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.DBAndRedisConfigDTO;
import com.github.loj.pojo.dto.EmailConfigDTO;
import com.github.loj.pojo.dto.TestEmailDTO;
import com.github.loj.pojo.dto.WebConfigDTO;
import com.github.loj.service.admin.system.ConfigService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/config")
public class ConfigController {

    @Autowired
    private ConfigService configService;

    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    @RequestMapping("/get-service-info")
    public CommonResult<JSONObject> getServiceInfo() {
        return configService.getServiceInfo();
    }

    @RequiresRoles(value = {"root", "admin", "problem_admin"}, logical = Logical.OR)
    @RequestMapping("/get-judge-service-info")
    public CommonResult<List<JSONObject>> getJudgeServiceInfo() {
        return configService.getJudgeServiceInfo();
    }

    @RequiresPermissions("system_info_admin")
    @RequestMapping("/get-web-config")
    public CommonResult<WebConfigDTO> getWebConfig() {
        return configService.getWebConfig();
    }

    @RequiresPermissions("system_info_admin")
    @DeleteMapping("/home-carousel")
    public CommonResult<Void> deleteHomeCarousel(@RequestParam("id") Long id) {

        return configService.deleteHomeCarousel(id);
    }

    @RequiresPermissions("system_info_admin")
    @PutMapping("/set-web-config")
    public CommonResult<Void> setWebConfig(@RequestBody WebConfigDTO config) {

        return configService.setWebConfig(config);
    }

    @RequiresPermissions("system_info_admin")
    @GetMapping("/get-email-config")
    public CommonResult<EmailConfigDTO> getEmailConfig() {
        return configService.getEmailConfig();
    }

    @RequiresPermissions("system_info_admin")
    @PutMapping("/set-email-config")
    public CommonResult<Void> setEmailConfig(@RequestBody EmailConfigDTO config) {
        return configService.setEmailConfig(config);
    }

    @RequiresPermissions("system_info_admin")
    @PostMapping("/test-email")
    public CommonResult<Void> testEmail(@RequestBody TestEmailDTO testEmailDTO) {
        return configService.testEmail(testEmailDTO);
    }

    @RequiresPermissions("system_info_admin")
    @PostMapping("/get-db-and-redis-config")
    public CommonResult<DBAndRedisConfigDTO> getDBAndRedisConfig() {
        return configService.getDBAndRedisConfig();
    }

    @RequiresPermissions("system_info_admin")
    @PutMapping("/set-db-and-redis-config")
    public CommonResult<Void> setDBAndRedisConfig(@RequestBody DBAndRedisConfigDTO config) {
        return configService.setDBAndRedisConfig(config);
    }
}
