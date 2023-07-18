package com.github.loj.dao.discussion.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.discussion.ReplyEntityService;
import com.github.loj.mapper.ReplyMapper;
import com.github.loj.pojo.entity.discussion.Reply;
import org.springframework.stereotype.Service;

@Service
public class ReplyEntityServiceImpl extends ServiceImpl<ReplyMapper, Reply> implements ReplyEntityService {
}
