package com.github.loj.pojo.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;
import java.util.List;

/**
 * @author lxhcaicai
 * @date 2023/5/9 20:16
 */
@Data
public class SubmitIdListDTO {
    @NotEmpty(message = "查询的提交id列表不能为空")
    private List<Long> submitIds;

    private Long cid;
}
