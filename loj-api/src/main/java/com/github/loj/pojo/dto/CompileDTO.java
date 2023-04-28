package com.github.loj.pojo.dto;

import lombok.Data;

import java.util.HashMap;

/**
 * @author lxhcaicai
 * @date 2023/4/28 22:50
 */
@Data
public class CompileDTO {
    private static final long serialVersionUID = 333L;

    /**
     * 编译的源代码
     */
    private String code;

    /**
     * 编译的源代码相关的题目id
     */
    private Long pid;

    /**
     * 编译的源代码所选语言
     */
    private String language;

    /**
     * 调用判题机的凭证
     */
    private String token;

    /**
     * 编译所需的额外文件，key:文件名,value:文件内容
     */
    private HashMap<String,String> extraFiles;
}
