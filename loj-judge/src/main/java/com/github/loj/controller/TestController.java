package com.github.loj.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/test")
public class TestController {

    @GetMapping("/hello")
    public Map test() {
        Map<String,Object> map = new HashMap<>();
        map.put("success", "恭喜你启动成功");
        return map;
    }
}
