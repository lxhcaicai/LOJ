package com.github.loj.controller.test;

import com.github.loj.common.result.CommonResult;
import com.github.loj.common.result.ResultStatus;
import com.github.loj.utils.RedisUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @author lxhcaicai
 * @date 2023/4/25 21:04
 */
@RestController
public class RedisController {

    @Resource
    RedisUtils redisUtils;

    @GetMapping("/clean/redis")
    public CommonResult<Void> cleanRedis() {
        redisUtils.delAllkeys();
        return CommonResult.successResponse("清除redis缓存成功!");
    }
}
