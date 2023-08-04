package com.github.loj.manager.admin.tag;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.loj.common.exception.StatusFailException;
import com.github.loj.dao.problem.TagEntityService;
import com.github.loj.pojo.entity.problem.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Slf4j(topic = "loj")
public class AdminTagManager {

    @Autowired
    private TagEntityService tagEntityService;

    public Tag addTag(Tag tag) throws StatusFailException {

        QueryWrapper<Tag> tagQueryWrapper = new QueryWrapper<>();
        tagQueryWrapper.eq(tag.getGid() != null, "gid", tag.getGid())
                .eq("name",tag.getName())
                .eq("oj",tag.getOj());

        Tag existTag = tagEntityService.getOne(tagQueryWrapper,false);

        if(existTag != null) {
            throw new StatusFailException("该标签名称已存在！请勿重复添加！");
        }

        boolean isOk = tagEntityService.save(tag);
        if(!isOk) {
            throw new StatusFailException("添加失败");
        }
        return tag;
    }
}
