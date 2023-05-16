package com.github.loj.manager.oj;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.dao.problem.TagClassificationEntityService;
import com.github.loj.dao.problem.TagEntityService;
import com.github.loj.dao.training.TrainingCategoryEntityService;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.pojo.entity.problem.TagClassification;
import com.github.loj.pojo.entity.training.TrainingCategory;
import com.github.loj.pojo.vo.CaptchaVO;
import com.github.loj.pojo.vo.ProblemTagVO;
import com.github.loj.utils.RedisUtils;
import com.wf.captcha.ArithmeticCaptcha;
import com.wf.captcha.base.Captcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.*;

/**
 * @author lxhcaicai
 * @date 2023/5/13 20:16
 */
@Component
public class CommonManager {

    @Autowired
    private TagClassificationEntityService tagClassificationEntityService;

    @Autowired
    private TagEntityService tagEntityService;

    @Autowired
    private RedisUtils redisUtils;

    @Autowired
    private TrainingCategoryEntityService trainingCategoryEntityService;

    public CaptchaVO getCaptcha() {
        ArithmeticCaptcha specCaptcha = new ArithmeticCaptcha(90, 30, 4);
        specCaptcha.setCharType(Captcha.TYPE_DEFAULT);
        // 2位数运算
        specCaptcha.setLen(2);
        String verCode = specCaptcha.text().toLowerCase();
        String key = IdUtil.simpleUUID();
        // 存入redis并设置过期时间为30分钟
        redisUtils.set(key, verCode, 1800);
        // 将key和base64返回给前端
        CaptchaVO captchaVO = new CaptchaVO()
                .setImg(specCaptcha.toBase64())
                .setCaptchaKey(key);
        return captchaVO;
    }

    public List<ProblemTagVO> getProblemTagsAndClassification(String oj) {
        oj = oj.toUpperCase();
        List<ProblemTagVO> problemTagVOList = new ArrayList<>();
        List<TagClassification> classificationList = null;
        List<Tag> tagList = null;
        if(oj.equals("ALL")) {
            classificationList = tagClassificationEntityService.list();
            QueryWrapper<Tag> tagQueryWrapper = new QueryWrapper<>();
            tagQueryWrapper.isNull("gid");
            tagList = tagEntityService.list(tagQueryWrapper);
        } else {
            QueryWrapper<TagClassification> tagClassificationQueryWrapper = new QueryWrapper<>();
            tagClassificationQueryWrapper.eq("oj", oj)
                    .orderByAsc("`rank`");
            classificationList = tagClassificationEntityService.list(tagClassificationQueryWrapper);

            QueryWrapper<Tag> tagQueryWrapper = new QueryWrapper<>();
            tagQueryWrapper.isNull("gid");
            tagQueryWrapper.eq("oj", oj);
            tagList = tagEntityService.list(tagQueryWrapper);
        }
        if(CollectionUtils.isEmpty(classificationList)) {
            ProblemTagVO problemTagVO = new ProblemTagVO();
            problemTagVO.setTagList(tagList);
            problemTagVOList.add(problemTagVO);
        } else {
            for(TagClassification classification: classificationList) {
                ProblemTagVO problemTagVO = new ProblemTagVO();
                problemTagVO.setClassification(classification);
                List<Tag> tags = new ArrayList<>();
                if(!CollectionUtils.isEmpty(tagList)) {
                    Iterator<Tag> it = tagList.iterator();
                    while ((it.hasNext())) {
                        Tag tag = it.next();
                        if(classification.getId().equals(tag.getTcid())) {
                            tags.add(tag);
                            it.remove();
                        }
                    }
                }
                problemTagVO.setTagList(tags);
                problemTagVOList.add(problemTagVO);
            }
            if(tagList.size() > 0) {
                ProblemTagVO problemTagVO = new ProblemTagVO();
                problemTagVO.setTagList(tagList);
                problemTagVOList.add(problemTagVO);
            }
        }
        if(oj.equals("ALL")) {
            Collections.sort(problemTagVOList, problemTagVoComparator);
        }
        return problemTagVOList;
    }

    public Comparator<ProblemTagVO> problemTagVoComparator = (p1, p2) -> {
        if(p1 == null) {
            return 1;
        }
        if(p2 == null) {
            return 1;
        }
        if(p1.getClassification() == null) {
            return 1;
        }
        if(p2.getClassification() == null) {
            return -1;
        }
        TagClassification p1Classification = p1.getClassification();
        TagClassification p2Classification = p2.getClassification();
        if(Objects.equals(p1Classification.getOj(), p2Classification.getOj())) {
            return p1Classification.getRank().compareTo(p2Classification.getRank());
        } else {
            if("ME".equals(p1Classification.getOj())) {
                return -1;
            } else if("ME".equals(p2Classification.getOj())) {
                return 1;
            } else {
                return p1Classification.getOj().compareTo(p2Classification.getOj());
            }
        }
    };

    public List<TrainingCategory> getTrainingCategory() {
        QueryWrapper<TrainingCategory> trainingCategoryQueryWrapper = new QueryWrapper<>();
        trainingCategoryQueryWrapper.isNull("gid");
        return trainingCategoryEntityService.list(trainingCategoryQueryWrapper);
    }

}
