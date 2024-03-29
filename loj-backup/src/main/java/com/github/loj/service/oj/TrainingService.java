package com.github.loj.service.oj;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.dto.RegisterTrainingDTO;
import com.github.loj.pojo.vo.AccessVO;
import com.github.loj.pojo.vo.ProblemVO;
import com.github.loj.pojo.vo.TrainingRankVO;
import com.github.loj.pojo.vo.TrainingVO;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/16 22:11
 */
public interface TrainingService {

    public CommonResult<IPage<TrainingVO>> getTrainingList(Integer limit, Integer currentPage, String keyword, Long categoryId, String auth);

    public CommonResult<TrainingVO> getTraining(Long tid);

    public CommonResult<AccessVO> getTrainingAccess(Long tid);

    public CommonResult<List<ProblemVO>> getTrainingProblemList(Long tid);

    public CommonResult<Void> toRegisterTraining(RegisterTrainingDTO registerTrainingDTO);

    public CommonResult<IPage<TrainingRankVO>> getTrainingRank(Long tid, Integer limit, Integer currentPage, String keyword);

}
