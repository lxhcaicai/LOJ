package com.github.loj.dao.training.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.training.TrainingEntityService;
import com.github.loj.dao.training.TrainingProblemEntityService;
import com.github.loj.mapper.TrainingMapper;
import com.github.loj.pojo.entity.training.Training;
import com.github.loj.pojo.entity.training.TrainingProblem;
import com.github.loj.pojo.vo.TrainingVO;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author lxhcaicai
 * @date 2023/5/11 0:16
 */
@Service
public class TrainingEntityServiceImpl extends ServiceImpl<TrainingMapper, Training> implements TrainingEntityService {


    @Resource
    private TrainingMapper trainingMapper;

    @Resource
    private TrainingProblemEntityService trainingProblemEntityService;

    @Override
    public Page<TrainingVO> getTrainingList(int limit,
                                            int currentPage,
                                            Long categoryId,
                                            String auth,
                                            String keyword,
                                            String currentUid) {

        //新建分页
        Page<TrainingVO> page = new Page<>(currentPage, limit);

        List<TrainingVO> trainingList = trainingMapper.getTrainingList(page, categoryId, auth, keyword);

        // 当前用户有登录，且训练列表不为空，则查询用户对于每个训练的做题进度
        if(!StringUtils.isEmpty(currentUid) && trainingList.size() > 0) {
            List<Long> tidList = trainingList.stream().map(TrainingVO::getId).collect(Collectors.toList());
            List<TrainingProblem> trainingProblemList = trainingProblemEntityService.getTrainingListAcceptedCountByUid(tidList, currentUid);

            HashMap<Long, Integer> tidMapCount = new HashMap<>(trainingList.size());
            for(TrainingProblem trainingProblem: trainingProblemList) {
                int count = tidMapCount.getOrDefault(trainingProblem.getTid(), 0);
                count ++;
                tidMapCount.put(trainingProblem.getTid(), count);
            }

            for(TrainingVO trainingVO: trainingList) {
                Integer count = tidMapCount.getOrDefault(trainingVO.getId(), 0);
                trainingVO.setAcCount(count);
            }
        }

        page.setRecords(trainingList);
        return page;
    }
}
