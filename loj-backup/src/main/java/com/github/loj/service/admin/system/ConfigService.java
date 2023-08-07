package com.github.loj.service.admin.system;

import cn.hutool.json.JSONObject;
import com.github.loj.common.result.CommonResult;

import java.util.List;


public interface ConfigService {
    public CommonResult<JSONObject> getServiceInfo();

    public CommonResult<List<JSONObject>> getJudgeServiceInfo();
}
