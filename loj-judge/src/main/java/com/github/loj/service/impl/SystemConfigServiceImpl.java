package com.github.loj.service.impl;

import cn.hutool.system.oshi.OshiUtil;
import com.github.loj.service.SystemConfigService;
import org.springframework.stereotype.Service;

import java.util.HashMap;


/**
 * @author lxhcaicai
 * @date 2023/4/17 22:57
 */
@Service
public class SystemConfigServiceImpl implements SystemConfigService {
    @Override
    public HashMap<String,Object>  getSystemConfig() {
        HashMap<String,Object> result = new HashMap<>();
        int cpuCores = Runtime.getRuntime().availableProcessors(); // cpu 核心数

        double totalVirtualMemory = OshiUtil.getMemory().getTotal(); // 总内存
        double freePhysicalMemorySize = OshiUtil.getMemory().getAvailable(); // 内存使用率
        double value = freePhysicalMemorySize / totalVirtualMemory;
        String percentMemoryLoad = String.format("%.2f", (1 - value) * 100) + "%";

        result.put("cpuCores", cpuCores);
        result.put("percentMemoryLoad",percentMemoryLoad);
        return result;
    }
}
