package com.github.loj.manager.admin.system;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.text.UnicodeUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import cn.hutool.system.oshi.OshiUtil;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.config.NacosSwitchConfig;
import com.github.loj.config.WebConfig;
import com.github.loj.dao.common.FileEntityService;
import com.github.loj.pojo.dto.WebConfigDTO;
import com.github.loj.pojo.entity.common.File;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.LinkedList;
import java.util.List;

@Component
@Slf4j(topic = "loj")
public class ConfigManager {

    @Autowired
    private DiscoveryClient discoveryClient;

    @Autowired
    private FileEntityService fileEntityService;

    @Autowired
    private NacosSwitchConfig nacosSwitchConfig;

    @Value("${spring.cloud.nacos.url}")
    private String NACOS_URL;

    @Value("${spring.application.name}")
    private String currentServiceName;

    @Value("${service-url.name}")
    private String judgeServiceName;

    @Autowired
    private RestTemplate restTemplate;

    public JSONObject getServiceInfo() {

        JSONObject result = new JSONObject();

        List<ServiceInstance> serviceInstances = discoveryClient.getInstances(currentServiceName);

        // 获取nacos中心配置所在的机器环境
        String response = restTemplate.getForObject(NACOS_URL + "/nacos/v1/ns/operator/metrics", String.class);

        JSONObject jsonObject = JSONUtil.parseObj(response);
        // 获取当前数据后台所在机器环境
        int cores = OshiUtil.getCpuInfo().getCpuNum(); // 当前机器的cpu核数
        double cpuLoad = 100 - OshiUtil.getCpuInfo().getFree();
        String percentCpuLoad = String.format("%.2f", cpuLoad) + "%"; // 当前服务所在机器cpu使用率

        double totalVirtualMemory = OshiUtil.getMemory().getTotal(); // 当前服务所在机器总内存
        double freePhysicalMemorySize = OshiUtil.getMemory().getAvailable(); // 当前服务所在机器空闲内存
        double value = freePhysicalMemorySize / totalVirtualMemory;
        String percentMemoryLoad = String.format("%.2f", (1 - value) * 100) + "%"; // 当前服务所在机器内存使用率

        result.put("nacos", jsonObject);
        result.put("backupCores", cores);
        result.put("backupService", serviceInstances);
        result.put("backupPercentCpuLoad", percentCpuLoad);
        result.put("backupPercentMemoryLoad", percentMemoryLoad);
        return result;
    }

    public List<JSONObject>  getJudgeServiceInfo() {
        List<JSONObject> serviceInfoList = new LinkedList<>();
        List<ServiceInstance> serviceInstances = discoveryClient.getInstances(judgeServiceName);
        for(ServiceInstance serviceInstance: serviceInstances) {
            try {
                String result = restTemplate.getForObject(serviceInstance.getUri() + "/get-sys-config", String.class);
                JSONObject jsonObject = JSONUtil.parseObj(result);
                jsonObject.put("service", serviceInstance);
                serviceInfoList.add(jsonObject);
            } catch (Exception e) {
                log.error("[Admin Dashboard] get judge service info error, uri={}, error={}", serviceInstance.getUri(), e);
            }
        }
        return serviceInfoList;
    }

    public WebConfigDTO getWebConfig() {
        WebConfig webConfig = nacosSwitchConfig.getWebConfig();
        return WebConfigDTO.builder()
                .baseUrl(UnicodeUtil.toString(webConfig.getBaseUrl()))
                .name(UnicodeUtil.toString(webConfig.getName()))
                .shortName(UnicodeUtil.toString(webConfig.getShortName()))
                .description(UnicodeUtil.toString(webConfig.getDescription()))
                .register(webConfig.getRegister())
                .recordName(UnicodeUtil.toString(webConfig.getRecordName()))
                .recordUrl(UnicodeUtil.toString(webConfig.getRecordUrl()))
                .projectName(UnicodeUtil.toString(webConfig.getProjectName()))
                .projectUrl(UnicodeUtil.toString(webConfig.getRecordUrl()))
                .build();
    }

    public void deleteHomeCarousel(Long id) throws StatusFailException {

        File imgFile = fileEntityService.getById(id);
        if(imgFile == null) {
            throw new StatusFailException("文件id错误，图片不存在");
        }
        boolean isOk = fileEntityService.removeById(id);
        if(isOk) {
            FileUtil.del(imgFile.getFilePath());
        } else {
            throw new StatusFailException("删除失败");
        }
    }
}
