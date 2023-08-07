package com.github.loj.service.admin.system;

import cn.hutool.json.JSONObject;
import com.github.loj.common.result.CommonResult;


public interface ConfigService {
    public CommonResult<JSONObject> getServiceInfo();
}
