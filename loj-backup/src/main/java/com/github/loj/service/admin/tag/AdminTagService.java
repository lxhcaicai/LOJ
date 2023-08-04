package com.github.loj.service.admin.tag;

import com.github.loj.common.result.CommonResult;
import com.github.loj.pojo.entity.problem.Tag;
import com.github.loj.pojo.entity.problem.TagClassification;

import java.util.List;

public interface AdminTagService {
    public CommonResult<Tag> addTag(Tag tag);

    public CommonResult<Void> updateTag(Tag tag);

    public CommonResult<Void> deleteTag(Long tid);

    public CommonResult<List<TagClassification>> getTagClassification(String oj);

    public CommonResult<TagClassification> addTagClassification(TagClassification tagClassification);
}
