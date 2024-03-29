package com.github.loj.service.oj;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.PidListDTO;
import com.github.loj.pojo.vo.*;

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

    public CommonResult<RandomProblemVO> getRandomProblem();

    public CommonResult<ProblemInfoVO> getProblemInfo(String problemId, Long gid);

    public CommonResult<LastAcceptedCodeVO> getUserLastAcceptedCode(Long pid, Long cid);

    public CommonResult<List<ProblemFullScreenListVO>> getFullScreenProblemList(Long tid, Long cid);

}
