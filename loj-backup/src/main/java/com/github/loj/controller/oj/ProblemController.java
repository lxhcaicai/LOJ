package com.github.loj.controller.oj;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.annotation.AnonApi;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.PidListDTO;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.pojo.vo.RandomProblemVO;
import com.github.loj.service.oj.ProblemService;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/15 21:45
 * 问题数据控制类，处理题目列表请求，题目内容请求。
 */
@RestController
@RequestMapping("/api")
public class ProblemController {

    @Autowired
    private ProblemService problemService;


    /**
     * 获取题目列表分页
     * @param limit
     * @param currentPage
     * @param keyword
     * @param tagId
     * @param difficulty
     * @param oj
     * @return
     */
    @RequestMapping(value = "/get-problem-list", method = RequestMethod.GET)
    @AnonApi
    public CommonResult<Page<ProblemVO>> getProblemList(@RequestParam(value = "limit", required = false)Integer limit,
                                                        @RequestParam(value = "currentPage", required = false)Integer currentPage,
                                                        @RequestParam(value = "keyword", required = false) String keyword,
                                                        @RequestParam(value = "tagId", required = false)List<Long> tagId,
                                                        @RequestParam(value = "difficulty",required = false) Integer difficulty,
                                                        @RequestParam(value = "oj", required = false) String oj) {

        return problemService.getProblemList(limit,currentPage,keyword, tagId, difficulty, oj);
    }

    /**
     * 获取用户对应该题目列表中各个题目的做题情况
     * @param pidListDTO
     * @return
     */
    @RequiresAuthentication
    @PostMapping("/get-user-problem-status")
    public CommonResult<HashMap<Long,Object>> getUserProblemStatus(@Validated @RequestBody PidListDTO pidListDTO) {
        return problemService.getUserProblemStatus(pidListDTO);
    }

    /**
     * 随机选取一道题目
     * @return
     */
    @GetMapping("/get-random-problem")
    @AnonApi
    public CommonResult<RandomProblemVO> getRandomProblem() {
        return problemService.getRandomProblem();
    }
}
