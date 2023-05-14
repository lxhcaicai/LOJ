package com.github.loj.service.oj.impl;

import com.github.loj.common.result.CommonResult;
import com.github.loj.manager.oj.HomeManager;
import com.github.loj.service.oj.HomeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/14 21:35
 */
@Service
public class HomeServiceImpl implements HomeService {

    @Resource
    private HomeManager homeManager;

    @Override
    public CommonResult<List<HashMap<String, Object>>> getHomeCarousel() {
        return CommonResult.successResponse(homeManager.getHomeCarousel());
    }
}
