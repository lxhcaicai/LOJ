package com.github.loj.pojo.vo;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @author lxhcaicai
 * @date 2023/5/13 21:56
 */
@Data
@Accessors(chain = true)
public class CheckUsernameOrEmailVO {
    private Boolean email;

    private Boolean username;
}
