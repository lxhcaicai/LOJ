package com.github.loj.pojo.vo;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.Data;

import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/5/25 0:11
 */
@Data
public class CommentListVO {

    private IPage<CommentVO> commentList;

    private HashMap<Integer, Boolean> commentLikeMap;

}
