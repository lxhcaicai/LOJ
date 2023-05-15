package com.github.loj.service.oj;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.PidListDTO;
import com.github.loj.pojo.vo.ProblemVO;

import java.util.HashMap;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/15 21:53
 */
public interface ProblemService {

    public CommonResult<Page<ProblemVO>> getProblemList(Integer limit, Integer currentPage,
                                                        String keyword, List<Long> tagId, Integer difficulty, String oj);

    public CommonResult<HashMap<Long,Object>> getUserProblemStatus(PidListDTO pidListDTO);

}
