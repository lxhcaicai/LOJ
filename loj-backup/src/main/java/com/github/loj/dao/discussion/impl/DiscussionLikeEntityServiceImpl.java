package com.github.loj.dao.discussion.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.discussion.DiscussionLikeEntityService;
import com.github.loj.mapper.DiscussionLikeMapper;
import com.github.loj.pojo.entity.discussion.DiscussionLike;
import org.springframework.stereotype.Service;

@Service
public class DiscussionLikeEntityServiceImpl extends ServiceImpl<DiscussionLikeMapper, DiscussionLike> implements DiscussionLikeEntityService {
}
