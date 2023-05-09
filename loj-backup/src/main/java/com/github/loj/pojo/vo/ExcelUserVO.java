package com.github.loj.pojo.vo;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @author lxhcaicai
 * @date 2023/5/9 21:22
 */
@Data
@Accessors(chain = true)
@ColumnWidth(25)
public class ExcelUserVO {

    @ExcelProperty(value = "用户名",index = 0)
    private String username;

    @ExcelProperty(value = "密码", index = 1)
    private String password;

}
