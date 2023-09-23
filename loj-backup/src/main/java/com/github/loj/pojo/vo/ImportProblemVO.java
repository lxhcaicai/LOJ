package com.github.loj.pojo.vo;

import lombok.Data;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

@ToString
@Data
@Accessors(chain = true)
public class ImportProblemVO implements Serializable {
    private HashMap<String,Object> problem;

    private List<String> languages;

    private List<HashMap<String,Object>> samples;

    private List<String> tags;

    private List<HashMap<String,String>> codeTemplates;

    private HashMap<String,String> userExtraFile;

    private HashMap<String,String> judgeExtraFile;

    private String judgeMode;
}
