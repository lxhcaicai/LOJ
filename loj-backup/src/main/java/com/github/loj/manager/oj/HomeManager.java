package com.github.loj.manager.oj;

import com.github.loj.dao.common.FileEntityService;
import com.github.loj.pojo.entity.common.File;
import com.github.loj.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/14 22:51
 */
@Component
public class HomeManager {

    @Autowired
    FileEntityService fileEntityService;

    /**
     * 获取主页轮播图
     * @return
     */
    public List<HashMap<String,Object>> getHomeCarousel() {
        List<File> fileList = fileEntityService.queryCarouselFileList();
        List<HashMap<String,Object>> apiList = fileList.stream().map(f -> {
            HashMap<String,Object> param = new HashMap<>(2);
            param.put("id", f.getId());
            param.put("url", Constants.File.IMG_API.getPath() + f.getName());
            return param;
        }).collect(Collectors.toList());
        return apiList;
    }

}
