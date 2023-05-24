package com.github.loj.dao.discussion.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.loj.dao.discussion.CommentLike;
import com.github.loj.dao.discussion.CommentLikeEntityService;
import com.github.loj.mapper.CommentLikeMapper;
import org.springframework.stereotype.Service;

/**
 * @author lxhcaicai
 * @date 2023/5/25 1:36
 */
@Service
public class CommentLikeEntityServiceImpl extends ServiceImpl<CommentLikeMapper, CommentLike> implements CommentLikeEntityService {
}
