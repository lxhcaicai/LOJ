package com.github.loj.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.loj.pojo.entity.training.TrainingProblem;
import com.github.loj.pojo.vo.ProblemFullScreenListVO;
import com.github.loj.pojo.vo.ProblemVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/7 22:32
 */
@Mapper
@Repository
public interface TrainingProblemMapper extends BaseMapper<TrainingProblem> {

    public List<Long> getTrainingProblemCount(@Param("tid") Long tid);

    public List<ProblemVO> getTrainingProblemList(@Param("tid") Long tid);

    public List<TrainingProblem> getPrivateTrainingProblemListByPid(@Param("pid") Long pid, @Param("uid") String uid);

    public List<TrainingProblem> getTrainingListAcceptedCountByUid(@Param("tidList") List<Long>  tidList,
                                                                   @Param("uid") String uid);

    public List<TrainingProblem> getGroupTrainingListAcceptedCountByUid(@Param("tidList") List<Long> tidList,
                                                                        @Param("gid") Long gid,
                                                                        @Param("uid") String uid);

    public List<ProblemFullScreenListVO> getTrainingFullScreenProblemList(@Param("tid") Long tid);

}
