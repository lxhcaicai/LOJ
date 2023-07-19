package com.github.loj.pojo.dto;

import com.github.loj.pojo.entity.discussion.Reply;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ReplyDTO {

    private Reply reply;

    private Integer did;

    private Integer quoteId;

    private String quoteType;
}
