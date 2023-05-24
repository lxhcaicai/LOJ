package com.github.loj.dao.discussion.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.discussion.DiscussionEntityService;
import com.github.loj.mapper.DiscussionMapper;
import com.github.loj.pojo.entity.discussion.Discussion;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:42
 */
@Service
public class DiscussionEntityServiceImpl extends ServiceImpl<DiscussionMapper, Discussion> implements DiscussionEntityService {
}
