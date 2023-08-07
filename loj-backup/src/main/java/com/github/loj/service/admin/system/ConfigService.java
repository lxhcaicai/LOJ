package com.github.loj.service.admin.system;

import cn.hutool.json.JSONObject;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.EmailConfigDTO;
import com.github.loj.pojo.dto.WebConfigDTO;

import java.util.List;


public interface ConfigService {
    public CommonResult<JSONObject> getServiceInfo();

    public CommonResult<List<JSONObject>> getJudgeServiceInfo();

    public CommonResult<WebConfigDTO> getWebConfig();

    public CommonResult<Void> deleteHomeCarousel(Long id);

    public CommonResult<Void> setWebConfig(WebConfigDTO config);

    public CommonResult<EmailConfigDTO> getEmailConfig();
}
