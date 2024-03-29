package com.github.loj.service.admin.system;

import cn.hutool.json.JSONObject;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.*;

import java.util.List;


public interface ConfigService {
    public CommonResult<JSONObject> getServiceInfo();

    public CommonResult<List<JSONObject>> getJudgeServiceInfo();

    public CommonResult<WebConfigDTO> getWebConfig();

    public CommonResult<Void> deleteHomeCarousel(Long id);

    public CommonResult<Void> setWebConfig(WebConfigDTO config);

    public CommonResult<EmailConfigDTO> getEmailConfig();

    public CommonResult<Void> setEmailConfig(EmailConfigDTO config);

    public CommonResult<Void> testEmail(TestEmailDTO testEmailDTO);

    public CommonResult<DBAndRedisConfigDTO> getDBAndRedisConfig();

    public CommonResult<Void> setDBAndRedisConfig(DBAndRedisConfigDTO config);

    public CommonResult<SwitchConfigDTO> getSwitchConfig();

    public CommonResult<Void> setSwitchConfig(SwitchConfigDTO config);
}
