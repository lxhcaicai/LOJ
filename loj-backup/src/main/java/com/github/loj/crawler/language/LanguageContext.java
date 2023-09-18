package com.github.loj.crawler.language;

import com.github.loj.pojo.entity.problem.Language;
import com.github.loj.utils.Constants;

import java.util.List;

public class LanguageContext {

    private LanguageStrategy languageStrategy;


    public LanguageContext(Constants.RemoteOJ remoteOJ) {
        switch (remoteOJ) {
            default:
                throw new RuntimeException("未知的OJ的名字，暂时不支持！");
        }
    }

    public List<Language> buildLanguageListByIds(List<Language> allLanguageList, List<String> langIdList) {
        return languageStrategy.buildLanguageListByIds(allLanguageList, langIdList);
    }

}
